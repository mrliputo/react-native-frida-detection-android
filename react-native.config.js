module.exports = {
  dependency: {
    platforms: {
      android: {
        sourceDir: './android',
        packageImportPath: 'import com.rnfridadetection.FridaDetectionPackage;',
        packageInstance: 'new FridaDetectionPackage()',
      },
      ios: null,
    },
  },
};
