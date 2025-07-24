Return-Path: <linux-efi+bounces-4470-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4156CB10029
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 07:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47D01CC5DA7
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 05:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07C0221FD4;
	Thu, 24 Jul 2025 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+HZl1rt"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DF82153EA;
	Thu, 24 Jul 2025 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753336231; cv=none; b=lG6KMwMdbAM6xibu6olBWNM88NpYPli+w5GjjM108ujue7QZQNu6SBGrpV+mjGMPyyuJyk2RruG1+LYblEOBJnIQ3d6U4xD3X+A25bWt3GDOcbdS65AQHZb8FhO43pv86bM/QB1ZKcDyglG12Nr567E77+Sqj/MWJmvPa2zNgYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753336231; c=relaxed/simple;
	bh=wNKQONSDACRjYYu6I5glKcwwkty7zb+PKkmvdUUj3Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoEhbjNU1CDxUNoUA5eeFB31LrDOptgL/XsKUKkHPhV/5KT245KvZzr4dDUB114dpWWQDSO5NU26Fq1f0rUvNuiaat/Wi1Xqd/M7GzIZtZ9/WuOhIoZlz/bScQxOnGvdRnzu2wx7VtDO68eV1qm7gyqLAGlJfhItzSnufN7nExE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+HZl1rt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AC7C4CEFB;
	Thu, 24 Jul 2025 05:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753336230;
	bh=wNKQONSDACRjYYu6I5glKcwwkty7zb+PKkmvdUUj3Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+HZl1rt2NsEtntfRh6EdRo59KNXptZi6pZx+Yrf7cIlLmr71/JLlWZuAyOeTQM6a
	 QagXP6QrI2p+FXqYRHHZ7XjXXGHD/aN7iPid8MJkn88iIkLQrCZ64w8w1N439rr4P0
	 JhwyXJQ0+BUkLdpctVPFwt6PfFYGcCP8BENbupOoSW7tkzRHikSmr9JAyjqmRLqE/0
	 fZVdqAHK8D+IHfTg7BC8eQL1k/rMnDpxqehelDjmBvAweYmiznUlNL9L7cwYxYk4tt
	 oWsaKfu9b7+CnEDYoSulWT+E5BiI7D+szglDWQD/0JTgL7hwR0tSQPkky0lFwA4wy+
	 bUamH4SrdTQuA==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Juergen Gross <jgross@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Roger Pau Monne <roger.pau@citrix.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Usama Arif <usama.arif@bytedance.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Huth <thuth@redhat.com>,
	Brian Gerst <brgerst@gmail.com>,
	kvm@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gavin Shan <gshan@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	James Morse <james.morse@arm.com>,
	Oza Pawandeep <quic_poza@quicinc.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Hans de Goede <hansg@kernel.org>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jan Beulich <jbeulich@suse.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kasan-dev@googlegroups.com,
	linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v4 2/4] x86: Handle KCOV __init vs inline mismatches
Date: Wed, 23 Jul 2025 22:50:26 -0700
Message-Id: <20250724055029.3623499-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724054419.it.405-kees@kernel.org>
References: <20250724054419.it.405-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8992; i=kees@kernel.org; h=from:subject; bh=wNKQONSDACRjYYu6I5glKcwwkty7zb+PKkmvdUUj3Ig=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmNJxdHq87byTrV+eeFmu+pxk9mrDErymjTSZ7z2arJo lvq7NmajlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIls1mZkeCNgEnr95wlTvr3M Ac17RX8sua+lf+fIw+nTLUNe7tJm2sTwV0gkcCqD+LfdNnp6PK+kC7LTjySv5f6gflLm/1bLzsz HjAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC appears to have kind of fragile inlining heuristics, in the
sense that it can change whether or not it inlines something based on
optimizations. It looks like the kcov instrumentation being added (or in
this case, removed) from a function changes the optimization results,
and some functions marked "inline" are _not_ inlined. In that case,
we end up with __init code calling a function not marked __init, and we
get the build warnings I'm trying to eliminate in the coming patch that
adds __no_sanitize_coverage to __init functions:

WARNING: modpost: vmlinux: section mismatch in reference: xbc_exit+0x8 (section: .text.unlikely) -> _xbc_exit (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: real_mode_size_needed+0x15 (section: .text.unlikely) -> real_mode_blob_end (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: __set_percpu_decrypted+0x16 (section: .text.unlikely) -> early_set_memory_decrypted (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: memblock_alloc_from+0x26 (section: .text.unlikely) -> memblock_alloc_try_nid (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: acpi_arch_set_root_pointer+0xc (section: .text.unlikely) -> x86_init (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: acpi_arch_get_root_pointer+0x8 (section: .text.unlikely) -> x86_init (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: efi_config_table_is_usable+0x16 (section: .text.unlikely) -> xen_efi_config_table_is_usable (section: .init.text)

This problem is somewhat fragile (though using either __always_inline
or __init will deterministically solve it), but we've tripped over
this before with GCC and the solution has usually been to just use
__always_inline and move on.

For x86 this means forcing several functions to be inline with
__always_inline.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <x86@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Roger Pau Monne <roger.pau@citrix.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Usama Arif <usama.arif@bytedance.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: <kvm@vger.kernel.org>
Cc: <ibm-acpi-devel@lists.sourceforge.net>
Cc: <platform-driver-x86@vger.kernel.org>
Cc: <linux-acpi@vger.kernel.org>
Cc: <linux-trace-kernel@vger.kernel.org>
Cc: <linux-efi@vger.kernel.org>
Cc: <linux-mm@kvack.org>
---
 arch/x86/include/asm/acpi.h     | 4 ++--
 arch/x86/include/asm/realmode.h | 2 +-
 include/linux/acpi.h            | 4 ++--
 include/linux/bootconfig.h      | 2 +-
 include/linux/efi.h             | 2 +-
 include/linux/memblock.h        | 2 +-
 include/linux/smp.h             | 2 +-
 arch/x86/kernel/kvm.c           | 2 +-
 arch/x86/mm/init_64.c           | 2 +-
 kernel/kexec_handover.c         | 4 ++--
 10 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 5ab1a4598d00..a03aa6f999d1 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -158,13 +158,13 @@ static inline bool acpi_has_cpu_in_madt(void)
 }
 
 #define ACPI_HAVE_ARCH_SET_ROOT_POINTER
-static inline void acpi_arch_set_root_pointer(u64 addr)
+static __always_inline void acpi_arch_set_root_pointer(u64 addr)
 {
 	x86_init.acpi.set_root_pointer(addr);
 }
 
 #define ACPI_HAVE_ARCH_GET_ROOT_POINTER
-static inline u64 acpi_arch_get_root_pointer(void)
+static __always_inline u64 acpi_arch_get_root_pointer(void)
 {
 	return x86_init.acpi.get_root_pointer();
 }
diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index f607081a022a..e406a1e92c63 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -78,7 +78,7 @@ extern unsigned char secondary_startup_64[];
 extern unsigned char secondary_startup_64_no_verify[];
 #endif
 
-static inline size_t real_mode_size_needed(void)
+static __always_inline size_t real_mode_size_needed(void)
 {
 	if (real_mode_header)
 		return 0;	/* already allocated. */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 71e692f95290..1c5bb1e887cd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -759,13 +759,13 @@ int acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem, int *timer_count)
 #endif
 
 #ifndef ACPI_HAVE_ARCH_SET_ROOT_POINTER
-static inline void acpi_arch_set_root_pointer(u64 addr)
+static __always_inline void acpi_arch_set_root_pointer(u64 addr)
 {
 }
 #endif
 
 #ifndef ACPI_HAVE_ARCH_GET_ROOT_POINTER
-static inline u64 acpi_arch_get_root_pointer(void)
+static __always_inline u64 acpi_arch_get_root_pointer(void)
 {
 	return 0;
 }
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 3f4b4ac527ca..25df9260d206 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -290,7 +290,7 @@ int __init xbc_get_info(int *node_size, size_t *data_size);
 /* XBC cleanup data structures */
 void __init _xbc_exit(bool early);
 
-static inline void xbc_exit(void)
+static __always_inline void xbc_exit(void)
 {
 	_xbc_exit(false);
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 50db7df0efab..a98cc39e7aaa 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1336,7 +1336,7 @@ struct linux_efi_initrd {
 
 bool xen_efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table);
 
-static inline
+static __always_inline
 bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 {
 	if (!IS_ENABLED(CONFIG_XEN_EFI))
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index bb19a2534224..b96746376e17 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -463,7 +463,7 @@ static inline void *memblock_alloc_raw(phys_addr_t size,
 					  NUMA_NO_NODE);
 }
 
-static inline void *memblock_alloc_from(phys_addr_t size,
+static __always_inline void *memblock_alloc_from(phys_addr_t size,
 						phys_addr_t align,
 						phys_addr_t min_addr)
 {
diff --git a/include/linux/smp.h b/include/linux/smp.h
index bea8d2826e09..18e9c918325e 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -221,7 +221,7 @@ static inline void wake_up_all_idle_cpus(void) {  }
 
 #ifdef CONFIG_UP_LATE_INIT
 extern void __init up_late_init(void);
-static inline void smp_init(void) { up_late_init(); }
+static __always_inline void smp_init(void) { up_late_init(); }
 #else
 static inline void smp_init(void) { }
 #endif
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 921c1c783bc1..8ae750cde0c6 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -420,7 +420,7 @@ static u64 kvm_steal_clock(int cpu)
 	return steal;
 }
 
-static inline void __set_percpu_decrypted(void *ptr, unsigned long size)
+static inline __init void __set_percpu_decrypted(void *ptr, unsigned long size)
 {
 	early_set_memory_decrypted((unsigned long) ptr, size);
 }
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index fdb6cab524f0..76e33bd7c556 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -805,7 +805,7 @@ kernel_physical_mapping_change(unsigned long paddr_start,
 }
 
 #ifndef CONFIG_NUMA
-static inline void x86_numa_init(void)
+static __always_inline void x86_numa_init(void)
 {
 	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
 }
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 49634cc3fb43..e49743ae52c5 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -310,8 +310,8 @@ static int kho_mem_serialize(struct kho_serialization *ser)
 	return -ENOMEM;
 }
 
-static void deserialize_bitmap(unsigned int order,
-			       struct khoser_mem_bitmap_ptr *elm)
+static void __init deserialize_bitmap(unsigned int order,
+				      struct khoser_mem_bitmap_ptr *elm)
 {
 	struct kho_mem_phys_bits *bitmap = KHOSER_LOAD_PTR(elm->bitmap);
 	unsigned long bit;
-- 
2.34.1


