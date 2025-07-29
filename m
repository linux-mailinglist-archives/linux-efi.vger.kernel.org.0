Return-Path: <linux-efi+bounces-4496-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA5FB14B5A
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jul 2025 11:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87FB3AEA63
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jul 2025 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70DE288525;
	Tue, 29 Jul 2025 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="T0M0CDw9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="buJJFSqR"
X-Original-To: linux-efi@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2EA288516;
	Tue, 29 Jul 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781754; cv=none; b=bT/pRl3zLqnTi0zhMb1oS/CsTQXmM4p/CbppHNqbcKGa0PQB5Dze+rDiEEEO6gA1e0OW3CDVa/BBiWdm/ZwyvSZ6jMhtlC+EgtqUNk+ntqEr8QlYFSxrHrssQRwUREy6C54UjebMRQFIVdmF5BQA+KD4P3iNQAJd+aHoDK8kcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781754; c=relaxed/simple;
	bh=g+vpis/SpU05sbo8Vmp+65jPjCMeiygq63OVHIYclpc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RqYzr4tC0eFZirougPWnfdyB0SyEhUwGX09OXiGsvSw/BDduxmjx9ocmezn65ZIi754jBuNqWZQf9KjsNCGVZzcVDBRAV781qEdBMlt4Y7uLBhi7is+8fzhpF24ZEg+V1CWA94KodiZXUhM0ir0jB5UhPlArX9LfCVWm8xCvQMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=T0M0CDw9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=buJJFSqR; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 83C331302001;
	Tue, 29 Jul 2025 05:35:49 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 29 Jul 2025 05:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753781749;
	 x=1753788949; bh=//ORI/NIeaAxh1YrBcckAswwPCVYsSmGgDQbyUkZAq8=; b=
	T0M0CDw90VbSLjna7vCcfe6mTMKCQ5endMYTmbm5F+kZuNuH4nc4BQuqm9/kFxYO
	cQELYjIMlvNKw4lJ6TCvYDOi6/GwbiFcq8V1FL9vON4SMrAYZBHEMyr3TapvJ32Q
	EuCcZwakLVvoMKIuhtNhw9MpoU1pIRLsrJBuKfw0mFvSH27q/GYmQZrzLEpJzswO
	GdKXjvNgbHsWZp/zE+Lg+mEXxE3fEhCRBZiE76eszktahyeCSVZQu6/kPCC3i4ZU
	uXu4AJQyuOJ4LmQeRHhGFlF5/SpiTMdgAiOzotcaAGdLwfh/H5w+q56btZTRpbJ7
	8OFkhBqJ4bK5fdS1U8Lbrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753781749; x=
	1753788949; bh=//ORI/NIeaAxh1YrBcckAswwPCVYsSmGgDQbyUkZAq8=; b=b
	uJJFSqRDP45vHQljpA7Vz5hxUd4Ye4pvXCFm5P+xUL3+GeSv2Jf9TQHBok2h5/y2
	8/PZ9GxYgAgtcQpNwox5EnnRktB7wG3sB0/j0KvR/u0lZ+CnNXcE0cmlrZO+y5ZV
	9yem6aXNjbvR7nkneYRaElOeon59Ocxqje2qLUNlkME5Sa7zPk4kjPv9pZqHNKNh
	lJV3swLKBE9qqltK0HfW4aTL83MPWE1v/JKK8VeT/xPzY6Nnm7iNFa/W7BubAO9J
	3ffb5NBK06Z9dokUuQl2fLD6FS2cFL30C4YYZiw2Iduv5cvgWcUOa8OL1iybrgXJ
	mUVNSzzn8C2I/WoIb3d+g==
X-ME-Sender: <xms:85WIaMyhieSSZlSTT0yHTn72mdFb2rWSE8kDBFOTHT75_XQsqr_aHQ>
    <xme:85WIaARI_U36niK6nz84PWzTnfAtsvJXL8KAZzHI9PFLHL4DmUN20-ne2_bXTcjrC
    kpOt2tuPjxukqMBaus>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeftddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomh
    dprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgt
    ohhmpdhrtghpthhtohepkhhirhhilhhlrdhshhhuthgvmhhovheslhhinhhugidrihhnth
    gvlhdrtghomhdprhgtphhtthhopehkvgigvggtsehlihhsthhsrdhinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrd
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhlvhhmsehlihhsthhsrdhlihhn
    uhigrdguvghvpdhrtghpthhtohepihgsmhdqrggtphhiqdguvghvvghlsehlihhsthhsrd
    hsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtohepmhgrohgsihgsoheslhhoohhn
    ghhsohhnrdgtnhdprhgtphhtthhopehjmhhorhhrihhssehnrghmvghirdhorhhg
X-ME-Proxy: <xmx:85WIaPnIcgaIATKBhxVWwK2-m2EfS8PuHbx7ehTzbZYYwEyhpGDr_A>
    <xmx:85WIaBEA4xy-CXl_decDoAPBk3bbcRqPT4EvT8P_Ytm06SHygu9mPg>
    <xmx:85WIaCzO8e92MmMJKlNqjd5utHh39rP5DKbEOnMvLMHZjHXDsuvHGQ>
    <xmx:85WIaKabnqwzN2tmkaM4lt9r0XopNiElVkycoMHYr9aBhvYdocxU-w>
    <xmx:9ZWIaNYEQ0icn8P3P-aCu5BQdrX6XDYXkrqNxknDiXSDJWuFBQyFgcIe>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9F298700065; Tue, 29 Jul 2025 05:35:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tf1c1d2456aa020de
Date: Tue, 29 Jul 2025 11:34:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <kees@kernel.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Paolo Bonzini" <pbonzini@redhat.com>,
 "Mike Rapoport" <rppt@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Vitaly Kuznetsov" <vkuznets@redhat.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Michal Wilczynski" <michal.wilczynski@intel.com>,
 "Juergen Gross" <jgross@suse.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Roger Pau Monne" <roger.pau@citrix.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Usama Arif" <usama.arif@bytedance.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 "Thomas Huth" <thuth@redhat.com>, "Brian Gerst" <brgerst@gmail.com>,
 kvm@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-mm@kvack.org, "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Gavin Shan" <gshan@redhat.com>,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 "James Morse" <james.morse@arm.com>,
 "Oza Pawandeep" <quic_poza@quicinc.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Hans de Goede" <hansg@kernel.org>,
 "Kirill A. Shutemov" <kas@kernel.org>, "Marco Elver" <elver@google.com>,
 "Andrey Konovalov" <andreyknvl@gmail.com>,
 "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
 "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nicolas.schier@linux.dev>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Andy Lutomirski" <luto@kernel.org>, "Baoquan He" <bhe@redhat.com>,
 "Alexander Graf" <graf@amazon.com>,
 "Changyuan Lyu" <changyuanl@google.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>,
 "Jan Beulich" <jbeulich@suse.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Bibo Mao" <maobibo@loongson.cn>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
 linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <f8bcf5ce-8b8b-4555-a210-14e1974eac92@app.fastmail.com>
In-Reply-To: <20250724055029.3623499-2-kees@kernel.org>
References: <20250724054419.it.405-kees@kernel.org>
 <20250724055029.3623499-2-kees@kernel.org>
Subject: Re: [PATCH v4 2/4] x86: Handle KCOV __init vs inline mismatches
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 24, 2025, at 07:50, Kees Cook wrote:
> GCC appears to have kind of fragile inlining heuristics, in the
> sense that it can change whether or not it inlines something based on
> optimizations. It looks like the kcov instrumentation being added (or in
> this case, removed) from a function changes the optimization results,
> and some functions marked "inline" are _not_ inlined. In that case,
> we end up with __init code calling a function not marked __init, and we
> get the build warnings I'm trying to eliminate in the coming patch that
> adds __no_sanitize_coverage to __init functions:
>
> WARNING: modpost: vmlinux: section mismatch in reference: xbc_exit+0x8 
> (section: .text.unlikely) -> _xbc_exit (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: 
> real_mode_size_needed+0x15 (section: .text.unlikely) -> 
> real_mode_blob_end (section: .init.data)
> WARNING: modpost: vmlinux: section mismatch in reference: 
> __set_percpu_decrypted+0x16 (section: .text.unlikely) -> 
> early_set_memory_decrypted (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: 
> memblock_alloc_from+0x26 (section: .text.unlikely) -> 
> memblock_alloc_try_nid (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: 
> acpi_arch_set_root_pointer+0xc (section: .text.unlikely) -> x86_init 
> (section: .init.data)
> WARNING: modpost: vmlinux: section mismatch in reference: 
> acpi_arch_get_root_pointer+0x8 (section: .text.unlikely) -> x86_init 
> (section: .init.data)
> WARNING: modpost: vmlinux: section mismatch in reference: 
> efi_config_table_is_usable+0x16 (section: .text.unlikely) -> 
> xen_efi_config_table_is_usable (section: .init.text)
>
> This problem is somewhat fragile (though using either __always_inline
> or __init will deterministically solve it), but we've tripped over
> this before with GCC and the solution has usually been to just use
> __always_inline and move on.
>
> For x86 this means forcing several functions to be inline with
> __always_inline.
>
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

In my randconfig tests, I got these ones as well:

WARNING: modpost: vmlinux: section mismatch in reference: early_page_ext_enabled+0x14 (section: .text.unlikely) -> early_
page_ext (section: .init.data)
x86_64-linux-ld: lm75.c:(.text+0xd25): undefined reference to `i3c_device_do_priv_xfers'

And one more with a private patch of mine.

These are the fixups that make it build for arm/arm64/x86
randconfigs for me, so you could fold them as well in
as well. I have already sent the i3c patch for upstream
but not the page_ext.h patch.

--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -57,7 +57,7 @@ extern bool early_page_ext;
 extern unsigned long page_ext_size;
 extern void pgdat_page_ext_init(struct pglist_data *pgdat);
 
-static inline bool early_page_ext_enabled(void)
+static __always_inline bool early_page_ext_enabled(void)
 {
        return early_page_ext;
 }
@@ -189,7 +189,7 @@ static inline struct page_ext *page_ext_iter_get(const struct page_ext_iter *ite
 #else /* !CONFIG_PAGE_EXTENSION */
 struct page_ext;
 
-static inline bool early_page_ext_enabled(void)
+static __always_inline bool early_page_ext_enabled(void)
 {
        return false;
 }
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -245,7 +245,7 @@ void i3c_driver_unregister(struct i3c_driver *drv);
  *
  * Return: 0 if both registrations succeeds, a negative error code otherwise.
  */
-static inline int i3c_i2c_driver_register(struct i3c_driver *i3cdrv,
+static __always_inline int i3c_i2c_driver_register(struct i3c_driver *i3cdrv,
                                          struct i2c_driver *i2cdrv)
 {
        int ret;
@@ -270,7 +270,7 @@ static inline int i3c_i2c_driver_register(struct i3c_driver *i3cdrv,
  * Note that when CONFIG_I3C is not enabled, this function only unregisters the
  * @i2cdrv.
  */
-static inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
+static __always_inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
                                             struct i2c_driver *i2cdrv)
 {
        if (IS_ENABLED(CONFIG_I3C))

As I understand, the underlying problem is less gcc inlining
being fragile, but more that gcc does not inline functions
when they have different __no_sanitize_coverage attributes.

      Arnd

