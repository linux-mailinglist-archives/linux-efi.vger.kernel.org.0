Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD574D7D98
	for <lists+linux-efi@lfdr.de>; Mon, 14 Mar 2022 09:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbiCNI2U (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Mar 2022 04:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbiCNI2T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Mar 2022 04:28:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289CC1C90D
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 01:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A917D6124F
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 08:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F444C340EE;
        Mon, 14 Mar 2022 08:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647246428;
        bh=ubbdt9lUOLVXhY8roFjfmBcF2EH6IX9ywQRSlISbxk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkT3yxu/Vdlndvx1q/NdeAIfYBwwKClIi13/NhQYfl+3+hlB10tlbIGp+Ps61uelG
         PJD0QiO5qtjy13I/7ecMwpN/2SQozdWtW0utEVVcS/eal2fVqXyCScxyanzGhcRYs8
         LA+Gs7eYSUBqK3SJNzd4y8qQiQtVfYuui/8pU+eUtGq9oVn4HFAWnS2mkGT7MDcQbz
         w3XS2fBb2Kzbu3DcknId+OEtvR4Xn04gxaSFdcVDA3edmCSCyyX2zhNIvfeFdwQy5V
         qQfdzx6lXKtIs53h3/srMydxIVM9oe/gEh2dBSU4atwCavOoZiUjo5DtYCOExiX8j+
         36M21a1jEr0Aw==
From:   ardb@kernel.org
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@google.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Fuad Tabba <tabba@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC PATCH v0 3/6] Add paging code to manage the full ID map
Date:   Mon, 14 Mar 2022 09:26:41 +0100
Message-Id: <20220314082644.3436071-4-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220314082644.3436071-1-ardb@kernel.org>
References: <20220314082644.3436071-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@google.com>

We enter with a minimal ID map carried in NOR flash, but in order to
load anything into DRAM and boot it, we need to map the memory first.

So add a paging module loosely based on the libhermit project's code,
but with a few tweaks and necessary fixes. (In particular, remove all
the code that is irrelevant for 1:1 mappings)

This code needs some more work: it currently greedily maps all memory
ranges down to pages, which is unnecessary, and costly in terms of heap
footprint. It also fails to deal with the need to split block mappings
into table mappings.
---
 Cargo.lock       |   7 +
 Cargo.toml       |   1 +
 efilite.lds      |   1 +
 src/main.rs      |  44 ++
 src/pagealloc.rs |  44 ++
 src/paging.rs    | 499 ++++++++++++++++++++
 6 files changed, 596 insertions(+)

diff --git a/Cargo.lock b/Cargo.lock
index 2750d4a3937c..8ad5db72fef6 100644
--- a/Cargo.lock
+++ b/Cargo.lock
@@ -2,6 +2,12 @@
 # It is not intended for manual editing.
 version = 3
 
+[[package]]
+name = "bitflags"
+version = "1.3.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
+
 [[package]]
 name = "cfg-if"
 version = "1.0.0"
@@ -12,6 +18,7 @@ checksum = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
 name = "efilite"
 version = "0.1.0"
 dependencies = [
+ "bitflags",
  "fdt",
  "linked_list_allocator",
  "log",
diff --git a/Cargo.toml b/Cargo.toml
index b073376d9e16..defa16ec4ab1 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -11,6 +11,7 @@ linked_list_allocator = "0.9.1"
 log = "0.4.14"
 mmio = "2.1.0"
 fdt = "0.1.3"
+bitflags = "1.3"
 
 [profile.dev]
 panic = "abort"
diff --git a/efilite.lds b/efilite.lds
index 0632cbaf8e4e..e460f9e9b917 100644
--- a/efilite.lds
+++ b/efilite.lds
@@ -27,6 +27,7 @@ SECTIONS
 	.dtb (NOLOAD) : {
 		_dtb = .;
 		. += 0x200000;
+		_dtb_end = .;
 	} >ram
 
 	/*
diff --git a/src/main.rs b/src/main.rs
index 6d880732b469..af58ccc0318d 100644
--- a/src/main.rs
+++ b/src/main.rs
@@ -2,19 +2,30 @@
 
 #![no_std]
 #![no_main]
+// needed by the paging code
+#![allow(incomplete_features)]
+#![feature(specialization)]
 
 mod console;
 mod cstring;
+mod pagealloc;
+mod paging;
 
 use core::{arch::global_asm, panic::PanicInfo};
 use linked_list_allocator::LockedHeap;
 use log::{error, info};
 
+use crate::paging::{PageTableEntryFlags, VirtAddr};
+
+#[macro_use]
+extern crate bitflags;
+
 #[global_allocator]
 pub static ALLOCATOR: LockedHeap = LockedHeap::empty();
 
 extern "C" {
     static _dtb: u8;
+    static _dtb_end: u8;
 }
 
 #[no_mangle]
@@ -38,6 +49,39 @@ extern "C" fn efilite_main(base: usize, mapped: usize, used: usize) {
     fdt.chosen()
         .bootargs()
         .map(|args| info!("/chosen/bootargs: {:?}\n", args));
+
+    paging::init();
+
+    let mut mem_flags = PageTableEntryFlags::empty();
+    mem_flags.normal().non_global().execute_disable();
+
+    info!("Mapping all DRAM regions found in the DT:\n");
+    for reg in fdt.memory().regions() {
+        if let Some(size) = reg.size {
+            paging::map_range(reg.starting_address as VirtAddr, size as u64, mem_flags);
+        }
+    }
+
+    info!("Remapping initial DRAM regions:\n");
+
+    // Ensure that the initial DRAM region remains mapped
+    paging::map_range(base as VirtAddr, mapped as u64, mem_flags);
+
+    // Ensure that the DT retains its global R/O mapping
+    let mut nor_flags = PageTableEntryFlags::empty();
+    nor_flags.normal().read_only();
+    paging::map_range(
+        unsafe { &_dtb as *const _ } as VirtAddr,
+        unsafe { &_dtb_end as *const _ as u64 - &_dtb as *const _ as u64 },
+        nor_flags,
+    );
+
+    // Switch to the new ID map so we can use all of DRAM
+    paging::activate();
+
+    // Switch back to the initial ID map so we can remap
+    // the loaded kernel image with different permissions
+    paging::deactivate();
 }
 
 #[no_mangle]
diff --git a/src/pagealloc.rs b/src/pagealloc.rs
new file mode 100644
index 000000000000..f91043000033
--- /dev/null
+++ b/src/pagealloc.rs
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+use core::alloc::GlobalAlloc;
+use core::arch::asm;
+
+use crate::paging::{BasePageSize, PageSize};
+use crate::ALLOCATOR;
+
+const DCZID_BS_MASK: u64 = 0xf;
+
+pub fn get_zeroed_page() -> u64 {
+    let layout =
+        core::alloc::Layout::from_size_align(BasePageSize::SIZE, BasePageSize::SIZE).unwrap();
+    let page = unsafe { ALLOCATOR.alloc(layout) };
+    if page.is_null() {
+        panic!("Out of memory!");
+    }
+
+    let dczid = unsafe {
+        let mut l: u64;
+        asm!("mrs {reg}, dczid_el0",
+             reg = out(reg) l,
+             options(pure, nomem, nostack, preserves_flags),
+        );
+        l
+    };
+
+    let line_shift = 2 + (dczid & DCZID_BS_MASK);
+    let line_size: isize = 1 << line_shift;
+    let num_lines = BasePageSize::SIZE >> line_shift;
+    let mut offset: isize = 0;
+
+    for _ in 1..=num_lines {
+        unsafe {
+            asm!(
+                "dc zva, {line}",
+                 line = in(reg) page.offset(offset),
+                 options(nostack, preserves_flags),
+            );
+        }
+        offset += line_size;
+    }
+    page as u64
+}
diff --git a/src/paging.rs b/src/paging.rs
new file mode 100644
index 000000000000..222c40e47c78
--- /dev/null
+++ b/src/paging.rs
@@ -0,0 +1,499 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+// Mostly derived from
+// https://github.com/hermitcore/libhermit-rs/blob/master/src/arch/aarch64/mm/paging.rs
+
+use core::arch::asm;
+use core::marker::PhantomData;
+use core::mem;
+use log::info;
+
+use crate::pagealloc;
+
+// Use a different ASID for the full ID map, as well as non-global attributes
+// for all its DRAM mappings. This way, we can ignore break-before-make rules
+// entirely when breaking down block mappings, as long as we don't do so while
+// the full ID map is active.
+const ASID: u64 = 1;
+
+// Number of Offset bits of a virtual address for a 4 KiB page, which are shifted away to get its Page Frame Number (PFN).
+const PAGE_BITS: usize = 12;
+
+// Number of bits of the index in each table (L0Table, L1Table, L2Table, L3Table).
+const PAGE_MAP_BITS: usize = 9;
+
+// A mask where PAGE_MAP_BITS are set to calculate a table index.
+const PAGE_MAP_MASK: usize = 0x1FF;
+
+#[repr(C, align(512))]
+struct IdMap {
+    entries: [u64; 64],
+}
+
+extern "C" {
+    // Root level of the initial ID map in NOR flash
+    static idmap: IdMap;
+}
+
+// Root level of the full ID map managed by this code
+static mut IDMAP: IdMap = IdMap {
+    entries: [0u64; 64],
+};
+
+macro_rules! align_down {
+    ($value:expr, $alignment:expr) => {
+        ($value) & !($alignment - 1)
+    };
+}
+
+pub fn init() {
+    // Clone the first entry, which covers the first 1 GB of PA space
+    // It contains the NOR flash and most peripherals
+    unsafe {
+        IDMAP.entries[0] = idmap.entries[0];
+    }
+}
+
+pub type VirtAddr = u64;
+pub type PhysAddr = u64;
+
+// A memory page of the size given by S.
+#[derive(Clone, Copy)]
+struct Page<S: PageSize> {
+    // Virtual memory address of this page.
+    // This is rounded to a page size boundary on creation.
+    virtual_address: VirtAddr,
+
+    // Required by Rust to support the S parameter.
+    size: PhantomData<S>,
+}
+
+impl<S: PageSize> Page<S> {
+    // Returns a PageIter to iterate from the given first Page to the given last Page (inclusive).
+    fn range(first: Self, last: Self) -> PageIter<S> {
+        assert!(first.virtual_address <= last.virtual_address);
+        PageIter {
+            current: first,
+            last: last,
+        }
+    }
+
+    // Returns a Page including the given virtual address.
+    // That means, the address is rounded down to a page size boundary.
+    fn including_address(virtual_address: VirtAddr) -> Self {
+        Self {
+            virtual_address: align_down!(virtual_address, S::SIZE as u64),
+            size: PhantomData,
+        }
+    }
+
+    // Returns the index of this page in the table given by L.
+    fn table_index<L: PageTableLevel>(&self) -> usize {
+        assert!(L::LEVEL <= S::MAP_LEVEL);
+        self.virtual_address as usize >> PAGE_BITS >> (3 - L::LEVEL) * PAGE_MAP_BITS & PAGE_MAP_MASK
+    }
+}
+
+struct PageIter<S: PageSize> {
+    current: Page<S>,
+    last: Page<S>,
+}
+
+impl<S: PageSize> Iterator for PageIter<S> {
+    type Item = Page<S>;
+
+    fn next(&mut self) -> Option<Page<S>> {
+        if self.current.virtual_address <= self.last.virtual_address {
+            let p = self.current;
+            self.current.virtual_address += S::SIZE as u64;
+            Some(p)
+        } else {
+            None
+        }
+    }
+}
+
+fn get_page_range<S: PageSize>(virtual_address: VirtAddr, count: u64) -> PageIter<S> {
+    let first_page = Page::<S>::including_address(virtual_address);
+    let last_page = Page::<S>::including_address(virtual_address + (count - 1) * S::SIZE as u64);
+    Page::range(first_page, last_page)
+}
+
+fn map<S: PageSize>(base: VirtAddr, size: u64, flags: PageTableEntryFlags) {
+    info!(
+        "Mapping memory at [0x{:X} - 0x{:X}] {:?}\n",
+        base,
+        base + size - 1,
+        flags
+    );
+
+    let range = get_page_range::<S>(base, size / S::SIZE as u64);
+    let root_pagetable = unsafe {
+        &mut *mem::transmute::<*mut u64, *mut PageTable<L1Table>>(&IDMAP as *const _ as *mut u64)
+    };
+    root_pagetable.map_pages(range, base, flags);
+}
+
+pub fn map_range(base: VirtAddr, size: u64, flags: PageTableEntryFlags) {
+    map::<BasePageSize>(base, size, flags);
+}
+
+pub fn activate() {
+    unsafe {
+        asm!(
+            "msr   ttbr0_el1, {ttbrval}",
+            "isb",
+            ttbrval = in(reg) &IDMAP as *const _ as u64 | (ASID << 48),
+            options(preserves_flags),
+        );
+    }
+}
+
+pub fn deactivate() {
+    unsafe {
+        asm!(
+            "msr   ttbr0_el1, {ttbrval}",
+            "isb",
+            "tlbi  aside1, {asid}",
+            "dsb   nsh",
+            "isb",
+            asid = in(reg) ASID << 48,
+            ttbrval = in(reg) &idmap as *const _ as u64,
+            options(preserves_flags),
+        );
+    }
+}
+
+bitflags! {
+    // Useful flags for an entry in either table (L0Table, L1Table, L2Table, L3Table).
+    //
+    // See ARM Architecture Reference Manual, ARMv8, for ARMv8-A Reference Profile, Issue C.a, Chapter D4.3.3
+    pub struct PageTableEntryFlags: u64 {
+        // Set if this entry is valid.
+        const PRESENT = 1 << 0;
+
+        // Set if this entry points to a table or a 4 KiB page.
+        const TABLE_OR_4KIB_PAGE = 1 << 1;
+
+        // Set if this entry points to device memory (non-gathering, non-reordering, no early write acknowledgement)
+        const DEVICE_NGNRE = 0 << 4 | 0 << 3 | 0 << 2;
+
+        // Set if this entry points to normal memory (cacheable)
+        const NORMAL = 0 << 4 | 0 << 3 | 1 << 2;
+
+        // Set if memory referenced by this entry shall be read-only.
+        const READ_ONLY = 1 << 7;
+
+        // Set if this entry shall be shared between all cores of the system.
+        const INNER_SHAREABLE = 1 << 8 | 1 << 9;
+
+        // Set if software has accessed this entry (for memory access or address translation).
+        const ACCESSED = 1 << 10;
+
+        // Set if this entry is scoped by ASID
+        const NON_GLOBAL = 1 << 11;
+
+        // Set if code execution shall be disabled for memory referenced by this entry in privileged mode.
+        const PRIVILEGED_EXECUTE_NEVER = 1 << 53;
+
+        // Set if code execution shall be disabled for memory referenced by this entry in unprivileged mode.
+        const UNPRIVILEGED_EXECUTE_NEVER = 1 << 54;
+
+        // Self-reference to the Level 0 page table
+        const SELF = 1 << 55;
+    }
+}
+
+impl PageTableEntryFlags {
+    // An empty set of flags for unused/zeroed table entries.
+    // Needed as long as empty() is no const function.
+    const BLANK: PageTableEntryFlags = PageTableEntryFlags { bits: 0 };
+
+    //	pub fn device(&mut self) -> &mut Self {
+    //		self.insert(PageTableEntryFlags::DEVICE_NGNRE);
+    //		self
+    //	}
+
+    pub fn normal(&mut self) -> &mut Self {
+        self.insert(PageTableEntryFlags::NORMAL);
+        self
+    }
+
+    pub fn read_only(&mut self) -> &mut Self {
+        self.insert(PageTableEntryFlags::READ_ONLY);
+        self
+    }
+
+    //	pub fn writable(&mut self) -> &mut Self {
+    //		self.remove(PageTableEntryFlags::READ_ONLY);
+    //		self
+    //	}
+
+    pub fn non_global(&mut self) -> &mut Self {
+        self.insert(PageTableEntryFlags::NON_GLOBAL);
+        self
+    }
+
+    pub fn execute_disable(&mut self) -> &mut Self {
+        self.insert(PageTableEntryFlags::PRIVILEGED_EXECUTE_NEVER);
+        self.insert(PageTableEntryFlags::UNPRIVILEGED_EXECUTE_NEVER);
+        self
+    }
+}
+
+// An interface to allow for a generic implementation of struct PageTable for all 4 page tables.
+// Must be implemented by all page tables.
+trait PageTableLevel {
+    // Numeric page table level
+    const LEVEL: usize;
+}
+
+trait PageTableLevelWithSubtables: PageTableLevel {
+    type SubtableLevel;
+}
+
+// The Level 1 Table (can map 1 GiB pages)
+enum L1Table {}
+impl PageTableLevel for L1Table {
+    const LEVEL: usize = 1;
+}
+
+impl PageTableLevelWithSubtables for L1Table {
+    type SubtableLevel = L2Table;
+}
+
+// The Level 2 Table (can map 2 MiB pages)
+enum L2Table {}
+impl PageTableLevel for L2Table {
+    const LEVEL: usize = 2;
+}
+
+impl PageTableLevelWithSubtables for L2Table {
+    type SubtableLevel = L3Table;
+}
+
+// The Level 3 Table (can map 4 KiB pages)
+enum L3Table {}
+impl PageTableLevel for L3Table {
+    const LEVEL: usize = 3;
+}
+
+// Representation of any page table in memory.
+// Parameter L supplies information for Rust's typing system to distinguish between the different tables.
+#[repr(align(4096))]
+struct PageTable<L: PageTableLevel> {
+    // Each page table has at most 512 entries (can be calculated using PAGE_MAP_BITS).
+    entries: [PageTableEntry; 1 << PAGE_MAP_BITS],
+
+    // Required by Rust to support the L parameter.
+    level: PhantomData<L>,
+}
+
+// A trait defining methods every page table has to implement.
+// This additional trait is necessary to make use of Rust's specialization feature and provide a default
+// implementation of some methods.
+trait PageTableMethods {
+    fn map_page_in_this_table<S: PageSize>(
+        &mut self,
+        page: Page<S>,
+        physical_address: PhysAddr,
+        flags: PageTableEntryFlags,
+    );
+    fn map_page<S: PageSize>(
+        &mut self,
+        page: Page<S>,
+        physical_address: PhysAddr,
+        flags: PageTableEntryFlags,
+    );
+}
+
+// An entry in either table
+#[derive(Clone, Copy)]
+pub struct PageTableEntry {
+    // Physical memory address this entry refers, combined with flags from PageTableEntryFlags.
+    physical_address_and_flags: PhysAddr,
+}
+
+impl PageTableEntry {
+    // Returns whether this entry is valid (present).
+    fn is_present(&self) -> bool {
+        (self.physical_address_and_flags & PageTableEntryFlags::PRESENT.bits()) != 0
+    }
+
+    // Mark this as a valid (present) entry and set address translation and flags.
+    //
+    // # Arguments
+    //
+    // * `physical_address` - The physical memory address this entry shall translate to
+    // * `flags` - Flags from PageTableEntryFlags (note that the PRESENT, INNER_SHAREABLE, and ACCESSED flags are set automatically)
+    fn set(&mut self, physical_address: PhysAddr, flags: PageTableEntryFlags) {
+        // Verify that the offset bits for a 4 KiB page are zero.
+        assert_eq!(
+            physical_address % BasePageSize::SIZE as u64,
+            0,
+            "Physical address is not on a 4 KiB page boundary (physical_address = {:#X})",
+            physical_address
+        );
+
+        let mut flags_to_set = flags;
+        flags_to_set.insert(PageTableEntryFlags::PRESENT);
+        self.physical_address_and_flags = physical_address | flags_to_set.bits();
+    }
+}
+
+impl<L: PageTableLevel> PageTableMethods for PageTable<L> {
+    // Maps a single page in this table to the given physical address.
+    //
+    // Must only be called if a page of this size is mapped at this page table level!
+    fn map_page_in_this_table<S: PageSize>(
+        &mut self,
+        page: Page<S>,
+        physical_address: PhysAddr,
+        flags: PageTableEntryFlags,
+    ) {
+        assert_eq!(L::LEVEL, S::MAP_LEVEL);
+        let index = page.table_index::<L>();
+
+        if flags == PageTableEntryFlags::BLANK {
+            // in this case we unmap the pages
+            self.entries[index].set(physical_address, flags);
+        } else {
+            let mut flags_to_set = flags;
+            flags_to_set.insert(PageTableEntryFlags::INNER_SHAREABLE);
+            flags_to_set.insert(PageTableEntryFlags::ACCESSED);
+            self.entries[index].set(physical_address, S::MAP_EXTRA_FLAG | flags_to_set);
+        }
+    }
+
+    // Maps a single page to the given physical address.
+    //
+    // This is the default implementation that just calls the map_page_in_this_table method.
+    // It is overridden by a specialized implementation for all tables with sub tables (all except L3Table).
+    default fn map_page<S: PageSize>(
+        &mut self,
+        page: Page<S>,
+        physical_address: PhysAddr,
+        flags: PageTableEntryFlags,
+    ) {
+        self.map_page_in_this_table::<S>(page, physical_address, flags)
+    }
+}
+
+impl<L: PageTableLevelWithSubtables> PageTable<L>
+where
+    L::SubtableLevel: PageTableLevel,
+{
+    // Returns the next subtable for the given page in the page table hierarchy.
+    //
+    // Must only be called if a page of this size is mapped in a subtable!
+    fn subtable<S: PageSize>(&self, page: Page<S>) -> &mut PageTable<L::SubtableLevel> {
+        assert!(L::LEVEL < S::MAP_LEVEL);
+
+        // Calculate the address of the subtable.
+        let index = page.table_index::<L>();
+        let subtable_address =
+            self.entries[index].physical_address_and_flags & !((1 << PAGE_BITS) - 1);
+        unsafe { &mut *(subtable_address as *mut PageTable<L::SubtableLevel>) }
+    }
+
+    // Maps a continuous range of pages.
+    //
+    // # Arguments
+    //
+    // * `range` - The range of pages of size S
+    // * `physical_address` - First physical address to map these pages to
+    // * `flags` - Flags from PageTableEntryFlags to set for the page table entry (e.g. WRITABLE or EXECUTE_DISABLE).
+    //             The PRESENT and ACCESSED are already set automatically.
+    fn map_pages<S: PageSize>(
+        &mut self,
+        range: PageIter<S>,
+        physical_address: PhysAddr,
+        flags: PageTableEntryFlags,
+    ) {
+        let mut current_physical_address = physical_address;
+
+        for page in range {
+            self.map_page::<S>(page, current_physical_address, flags);
+            current_physical_address += S::SIZE as u64;
+        }
+    }
+}
+
+impl<L: PageTableLevelWithSubtables> PageTableMethods for PageTable<L>
+where
+    L::SubtableLevel: PageTableLevel,
+{
+    // Maps a single page to the given physical address.
+    //
+    // This is the implementation for all tables with subtables (L0Table, L1Table, L2Table).
+    // It overrides the default implementation above.
+    fn map_page<S: PageSize>(
+        &mut self,
+        page: Page<S>,
+        physical_address: PhysAddr,
+        flags: PageTableEntryFlags,
+    ) {
+        assert!(L::LEVEL <= S::MAP_LEVEL);
+
+        if L::LEVEL < S::MAP_LEVEL {
+            let index = page.table_index::<L>();
+
+            // Does the table exist yet?
+            if !self.entries[index].is_present() {
+                // Allocate a single 4 KiB page for the new entry and mark it as a valid, writable subtable.
+                let physical_address = pagealloc::get_zeroed_page();
+                self.entries[index].set(physical_address, PageTableEntryFlags::TABLE_OR_4KIB_PAGE);
+            }
+
+            let subtable = self.subtable::<S>(page);
+            subtable.map_page::<S>(page, physical_address, flags)
+        } else {
+            // Calling the default implementation from a specialized one is not supported (yet),
+            // so we have to resort to an extra function.
+            self.map_page_in_this_table::<S>(page, physical_address, flags)
+        }
+    }
+}
+
+// A generic interface to support all possible page sizes.
+//
+// This is defined as a subtrait of Copy to enable #[derive(Clone, Copy)] for Page.
+// Currently, deriving implementations for these traits only works if all dependent types implement it as well.
+pub trait PageSize: Copy {
+    // The page size in bytes.
+    const SIZE: usize;
+
+    // The page table level at which a page of this size is mapped
+    const MAP_LEVEL: usize;
+
+    // Any extra flag that needs to be set to map a page of this size.
+    // For example: PageTableEntryFlags::TABLE_OR_4KIB_PAGE.
+    const MAP_EXTRA_FLAG: PageTableEntryFlags;
+}
+
+// A 4 KiB page mapped in the L3Table.
+#[derive(Clone, Copy)]
+pub enum BasePageSize {}
+impl PageSize for BasePageSize {
+    const SIZE: usize = 4096;
+    const MAP_LEVEL: usize = 3;
+    const MAP_EXTRA_FLAG: PageTableEntryFlags = PageTableEntryFlags::TABLE_OR_4KIB_PAGE;
+}
+
+// A 2 MiB page mapped in the L2Table.
+#[derive(Clone, Copy)]
+pub enum LargePageSize {}
+impl PageSize for LargePageSize {
+    const SIZE: usize = 2 * 1024 * 1024;
+    const MAP_LEVEL: usize = 2;
+    const MAP_EXTRA_FLAG: PageTableEntryFlags = PageTableEntryFlags::BLANK;
+}
+
+// A 1 GiB page mapped in the L1Table.
+#[derive(Clone, Copy)]
+pub enum HugePageSize {}
+impl PageSize for HugePageSize {
+    const SIZE: usize = 1024 * 1024 * 1024;
+    const MAP_LEVEL: usize = 1;
+    const MAP_EXTRA_FLAG: PageTableEntryFlags = PageTableEntryFlags::BLANK;
+}
-- 
2.30.2

