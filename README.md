# Increment Semantic Version

This is a GitHub action to bump a given semantic version, depending on a given version fragment.

## Inputs

### `current-version`

**Required** The current semantic version you want to increment. (e.g. 3.12.5)

### `release-type`

**Required** The versions fragment you want to increment.

Possible options are **[ major | feature | fix | refactor | docs ]**

## Outputs

### `new-version`

The incremented version.

## Example usage

    - name: Bump release version
      id: bump_version
      uses: gabclincrement-semantic-version@1.1.0
      with:
        current-version: '2.11.7' # also accepted: 'v2.11.7'
        release-type: 'feature'
    - name: Do something with your bumped release version
      run: echo ${{ steps.bump_version.outputs.next-version }}
      # will print 2.12.0
      
## input / output Examples

| release-type | current-version |     | output |
| ------------ | --------------- | --- | ------ |
| major        | 2.11.7          |     | 3.0.0  |
| major        | v2.11.7         |     | 3.0.0  |
| feature      | 2.11.7          |     | 2.12.0 |
| fix          | 2.11.7          |     | 2.11.8 |
| refactor     | 2.11.7          |     | 2.11.8 |
| docs         | 2.11.7          |     | 2.11.8 |

# License
The scripts and documentation in this project are released under the [MIT License](LICENSE)
