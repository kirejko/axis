// Register common components as global

const context = require.context('../components/common/', true, /\.vue$/)

context.keys()
  .forEach(module => {
    const componentName = _.kebabCase(
      module.replace(/(\.\/|\.vue)/g, '')
    )

    Vue.component(
      componentName,
      context(module).default
    )
  })
