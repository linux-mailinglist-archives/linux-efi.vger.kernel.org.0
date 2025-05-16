Return-Path: <linux-efi+bounces-3724-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D5EAB9ACA
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 13:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E38F97A949B
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 11:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2094822CBC4;
	Fri, 16 May 2025 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="BNzVBQ85";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h3DTjL8t"
X-Original-To: linux-efi@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C5D1FFC77;
	Fri, 16 May 2025 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747393785; cv=none; b=Y1Ty9WL2/0a1yqjkhCTOweCLhGsu/CbeC+pYGdM3HIrtz8w1k+VenaD9exEh6gNGrrArb6JsbRxhjFsp77DWEc6XoCPU/3LkfwS/iiV7zWcT2D7sUwY/o3Etye3DTOj0V/WBDvdh091DMbupQXkynjZsXccO7EK6BYDUoDkiq4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747393785; c=relaxed/simple;
	bh=n2/PNE2m3AviP8SNcAn9kOUTjgG6qdGdpUf8luEccbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFsQLu5FbV65maWaP+HBsKK/NmtVEX1llkEYrTnt4T9xKXpTOf4ZMZxxHMHp68c+dV3VUn/hrWPF4YZfMoQGdBLvtpjDQZKi4xuHmJGnMTkRMiYYmUZVaL7/rbsB2dsQlGbud74tiWUFJ8cbGiWtHVsfDwdCHOE0MeVAO/Twacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=BNzVBQ85; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h3DTjL8t; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B3C1114011E;
	Fri, 16 May 2025 07:09:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 16 May 2025 07:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1747393781; x=1747480181; bh=+QPy1vg6zut/GXopkbM8GabPiW4C2w7Y
	7/c1u0rdkQI=; b=BNzVBQ85gNmiiKTLfXIFFrZ9+8LsC10poEK6rV3Oiy1BkXwH
	cgBYINnlZioEnGAfwsE+XY4MdLrq1wleSo48l9W8ScHomHxpyxBifc0PDfYmI4gp
	5vVtyMOxGeEQREq7seq6BRxlrkb5EPwvl1SBzYVMBe8hCOG4JvA4XlXXvRMl+svs
	/ddR3gywY2/r8cu/Er64dJLkuY1HmzAyfcY8b0YS/4iFa2SsXUHB/ZFi/HguAmzm
	m7QqFqum6qxVGQdgAtXSYsTTghyw9ums/2LZ6/Bv6L1dc2qJDnlczhU+1yI6BWIp
	pl1lNGlH71CUXuiLqV9gkSXVgOGVgwz1XtrUyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747393781; x=
	1747480181; bh=+QPy1vg6zut/GXopkbM8GabPiW4C2w7Y7/c1u0rdkQI=; b=h
	3DTjL8tOAgbvKWBC3IojzwTE2qJTDlzh65zachKdXbrYeatVvCStEc82DV6otSBk
	2WX4ZCFXABWDDunKujpzSI+m3smNTd+fJCsIfeXMznIjUS7LozVZ10veJjVRfHSc
	qxFxb4ykIa//GQdzRssgRoSgVNNUpv8wyFvLGqWL/677YO0w8tzYUS3URUBtRE+W
	0P2lMq6/YqJtUqwIQSPy9oEytQ8Hib5Sxgar+S6pwrQUeBj4f8g1rkAAI6IdhebA
	O/oU7YaQ2BZFGY2WUD3Js1y4k/dvRD36u4/FgVQIHa0rg3STni9qyOKE8gVTBXw7
	f6lNCygOd43um051+YWig==
X-ME-Sender: <xms:8xwnaO9tYT-1UZzGOVUzPz-H4EBFR3O5yVVJ4oL0ZOSTgfBkaLZHiQ>
    <xme:8xwnaOukimdLePWwKlp9ydbVTYEoc-NpEMT_rUFshcRZ8yw8ULhNzD3veAyCdR80g
    dFKecYJUs6eBSjnqm0>
X-ME-Received: <xmr:8xwnaECyN3BiPr0tWsM7mwiaz3XVxOVo1WN_jput7zUZsoOubjkpALtXcD6pc4R87qzKhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddvheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddt
    tddunecuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrih
    hllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepueejuedvuddu
    udefvdeutdehgffhgeelvdejjedutefhgfeludffvddtjefgkeetnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgv
    mhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepjhhgrhhoshhssehsuhhsvgdrtghomhdprhgtphhtthhopehkihhrihhl
    lhdrshhhuhhtvghmohhvsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepth
    hglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhinhhgohesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepug
    grvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeig
    keeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihihtohhrrdgtohhmpd
    hrtghpthhtoheptghorhgsvghtsehlfihnrdhnvght
X-ME-Proxy: <xmx:8xwnaGfRv-kjSp6GiQtBodWn8t0aAhdRzzcOtcNuhxHhAAqMfa8Jbw>
    <xmx:8xwnaDN3BnYsLn6mhMr6uUsaGdZQ2MPqs3vtZMhJ2G_Rt8lMMPwY6g>
    <xmx:8xwnaAkvw61MI_tNRgzLxCaTKWdtNsYgE2CvWOvpot0M-FFmveIvVg>
    <xmx:8xwnaFuuRvXN18EGbKg6Ri_To7QH-MJxYSPlMCAm0DCSgiMHIGJOcQ>
    <xmx:9RwnaK5Z-QyTpvfEY0itapTyoPNfIyhxo4GfbZxrCXYDYKcuXfWfZ0QO>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 07:09:32 -0400 (EDT)
Date: Fri, 16 May 2025 14:09:28 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
	Michael Roth <michael.roth@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/3] x86/64/mm: Make 5-level paging support
 unconditional
Message-ID: <oqdepd27wqf4duawnb3qo2ra6ftjyzjqfxupfj3hkmxvp6w4tl@oy32plygk7dt>
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
 <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>
 <e5c5037f-6429-41bd-8166-de3aa1de01bd@suse.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5c5037f-6429-41bd-8166-de3aa1de01bd@suse.com>

On Fri, May 16, 2025 at 12:42:21PM +0200, Jürgen Groß wrote:
> On 16.05.25 11:15, Kirill A. Shutemov wrote:
> > Both Intel and AMD CPUs support 5-level paging, which is expected to
> > become more widely adopted in the future.
> > 
> > Remove CONFIG_X86_5LEVEL and ifdeffery for it to make it more readable.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Suggested-by: Borislav Petkov <bp@alien8.de>
> > ---
> >   Documentation/arch/x86/cpuinfo.rst            |  8 +++----
> >   .../arch/x86/x86_64/5level-paging.rst         |  9 --------
> >   arch/x86/Kconfig                              | 22 +------------------
> >   arch/x86/Kconfig.cpufeatures                  |  4 ----
> >   arch/x86/boot/compressed/pgtable_64.c         | 11 ++--------
> >   arch/x86/boot/header.S                        |  4 ----
> >   arch/x86/boot/startup/map_kernel.c            |  5 +----
> >   arch/x86/include/asm/page_64.h                |  2 --
> >   arch/x86/include/asm/page_64_types.h          |  7 ------
> >   arch/x86/include/asm/pgtable_64_types.h       | 18 ---------------
> >   arch/x86/kernel/alternative.c                 |  2 +-
> >   arch/x86/kernel/head64.c                      |  2 --
> >   arch/x86/kernel/head_64.S                     |  2 --
> >   arch/x86/mm/init.c                            |  4 ----
> >   arch/x86/mm/pgtable.c                         |  2 +-
> >   drivers/firmware/efi/libstub/x86-5lvl.c       |  2 +-
> >   16 files changed, 10 insertions(+), 94 deletions(-)
> 
> There are some instances of:
> 
> #if CONFIG_PGTABLE_LEVELS >= 5
> 
> in 64-bit-only code under arch/x86, which could be simplified, too.
> 
> They are still correct, but I wanted to hint at further code removals
> being possible.

Okay, fair enough. Fixup is below.

Did I miss anything else?

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 2fb7d53cf333..c9103a6fa06e 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -341,9 +341,7 @@ void __init set_vsyscall_pgtable_user_bits(pgd_t *root)
 	pgd = pgd_offset_pgd(root, VSYSCALL_ADDR);
 	set_pgd(pgd, __pgd(pgd_val(*pgd) | _PAGE_USER));
 	p4d = p4d_offset(pgd, VSYSCALL_ADDR);
-#if CONFIG_PGTABLE_LEVELS >= 5
 	set_p4d(p4d, __p4d(p4d_val(*p4d) | _PAGE_USER));
-#endif
 	pud = pud_offset(p4d, VSYSCALL_ADDR);
 	set_pud(pud, __pud(pud_val(*pud) | _PAGE_USER));
 	pmd = pmd_offset(pud, VSYSCALL_ADDR);
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index b89f8f1194a9..f06e5d6a2747 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -41,11 +41,9 @@ static inline void sync_initial_page_table(void) { }
 	pr_err("%s:%d: bad pud %p(%016lx)\n",		\
 	       __FILE__, __LINE__, &(e), pud_val(e))
 
-#if CONFIG_PGTABLE_LEVELS >= 5
 #define p4d_ERROR(e)					\
 	pr_err("%s:%d: bad p4d %p(%016lx)\n",		\
 	       __FILE__, __LINE__, &(e), p4d_val(e))
-#endif
 
 #define pgd_ERROR(e)					\
 	pr_err("%s:%d: bad pgd %p(%016lx)\n",		\
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 38971c6dcd4b..61c52bb80e33 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -578,7 +578,6 @@ static void xen_set_p4d(p4d_t *ptr, p4d_t val)
 	xen_mc_issue(XEN_LAZY_MMU);
 }
 
-#if CONFIG_PGTABLE_LEVELS >= 5
 __visible p4dval_t xen_p4d_val(p4d_t p4d)
 {
 	return pte_mfn_to_pfn(p4d.p4d);
@@ -592,7 +591,6 @@ __visible p4d_t xen_make_p4d(p4dval_t p4d)
 	return native_make_p4d(p4d);
 }
 PV_CALLEE_SAVE_REGS_THUNK(xen_make_p4d);
-#endif  /* CONFIG_PGTABLE_LEVELS >= 5 */
 
 static void xen_pmd_walk(struct mm_struct *mm, pmd_t *pmd,
 			 void (*func)(struct mm_struct *mm, struct page *,
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

