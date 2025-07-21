// Part of an initializer in a plugin
import { withPluginApi } from "discourse/lib/plugin-api";

function customizePostMetadata(api) {
  // Define a component to be used in the metadata section
  // The component should be created outside the transformer callback,
  // otherwise it can cause memory issues.
  const CustomMetadataComponent = <template>
      <div>
          <a href="{{@post.url}}" class="post-number">&nbsp;#{{@post.post_number}}</a>
      </div>
  </template>;

  api.registerValueTransformer(
      "post-meta-data-infos",
      ({ value: metadata, context: { post, metaDataInfoKeys } }) => {
          metadata.add(
              "custom-metadata-key",
              CustomMetadataComponent,
              {
                // Position it before the date
                // before: metaDataInfoKeys.DATE,
                // and after REPLY_TO_TAB
                after: metaDataInfoKeys.DATE,
              }
          );
      }
  );
}

export default {
  name: "discourse-show-post-number-tc",
  initialize() {
    withPluginApi((api) => {
      // ... other customizations
      customizePostMetadata(api);
    });
  }
};