Return-Path: <linux-efi+bounces-5249-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 519BCC1F07E
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 09:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3208F4E8E32
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EE8329C77;
	Thu, 30 Oct 2025 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YDr7j3UN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D9433769A;
	Thu, 30 Oct 2025 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813689; cv=none; b=H/m9vTcwHaWXCPG+/7VRzxIJwpR4EG21iyhxkLzVmAWEvsJngTw7MA996G1sSOB6RNYcezVWk2gkj54mIHihCe8rGLxFH4DpakzFEbWB6UxH6DdmdkdFqDganmizgfwk0b5ZYEz1KqzU35jW7ydFwlw2KNnSkRvIs/VDVlONIOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813689; c=relaxed/simple;
	bh=JUr7vfVO2iNOgchEy3iidELMUTgIg3MMbozaFDi6Ey0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WeQtZ+wPsaX6/AhvQbJiG8s6pY/VounSzdUBjCbCrczQ3oU2pubhIcKX95+Kk8DCwdZO3IBVXz0xK/jK7drISh3p7pdjdnQxmgpP86zZ4m8aU4Z2aysH9VZQyG+tBfrt4GNVa3B4RIu41PIhe+x6jCfQMaw5gzvzME9rUVwVVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=YDr7j3UN; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59U8eOrS2540003
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 30 Oct 2025 01:40:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59U8eOrS2540003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1761813627;
	bh=6GOvQqkqRO27RJgNlGF3VPURxUk8mGiK7+BM4hjB1U0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YDr7j3UNAMETG51xBxtiwo0BkxTBzyjt6WXAB6SJpjbJ0D9bLKWjdvfgmrRbwB3Ee
	 BvTkMcJm60GxwP+jlT9Pi4k1ux8sX3n0BfuMAUnXMYZGBV3t86gJWLEFGV4t1u5yhV
	 6QXAktAQJEG/6wnFjJW5mxWRGfOcAAH0YH4U3djSA364v04XzCvxq/5IZ4wh0CBSEn
	 wg6rCteEOAa1ZRwe1kfpVBLtOcqnpMTwKqp/s+AQT9/Ip/675GOs/KRukfnCD8HqPM
	 n+pDzBjEP6QQNM5A8y1DvNAJa5Shocb7Xp6SuoM04aO1XeQ83QTrKqEIWkgz1ndMDj
	 +1D7pRF8DWTXA==
Date: Thu, 30 Oct 2025 01:40:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>
CC: Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sean Christopherson <seanjc@google.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v11_9/9=5D_x86/cpu=3A_Enable_LA?=
 =?US-ASCII?Q?SS_by_default_during_CPU_initialization?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20251029210310.1155449-10-sohil.mehta@intel.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com> <20251029210310.1155449-10-sohil.mehta@intel.com>
Message-ID: <789ADBB5-F7AC-4B08-B343-F23260FB8FBC@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 29, 2025 2:03:10 PM PDT, Sohil Mehta <sohil=2Emehta@intel=2Ecom>=
 wrote:
>Linear Address Space Separation (LASS) mitigates a class of side-channel
>attacks that rely on speculative access across the user/kernel boundary=
=2E
>
>Enable LASS by default if the platform supports it=2E While at it, remove
>the comment above the SMAP/SMEP/UMIP/LASS setup instead of updating it,
>as the whole sequence is quite self-explanatory=2E
>
>The legacy vsyscall page is mapped at 0xffffffffff60?000=2E Prior to LASS=
,
>vsyscall page accesses would always generate a #PF=2E The kernel emulates
>the accesses in the #PF handler and returns the appropriate values to
>userspace=2E
>
>With LASS, these accesses are intercepted before the paging structures
>are traversed triggering a #GP instead of a #PF=2E To avoid breaking user
>applications, equivalent emulation support is required in the #GP
>handler=2E However, the #GP provides limited error information compared t=
o
>the #PF, making the emulation more complex=2E
>
>For now, keep it simple and disable LASS if vsyscall emulation is
>compiled in=2E This restricts LASS usability to newer environments where
>legacy vsyscalls are absolutely not needed=2E In future, LASS support can
>be expanded by enhancing the #GP handler=2E
>
>Signed-off-by: Sohil Mehta <sohil=2Emehta@intel=2Ecom>
>---
>v11:
> - Disable LASS if vsyscall emulation support is compiled in=2E
> - Drop Rick's review tag because of the new changes=2E
>
>v10
> - No change=2E
>---
> arch/x86/kernel/cpu/common=2Ec | 21 ++++++++++++++++++++-
> 1 file changed, 20 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/kernel/cpu/common=2Ec b/arch/x86/kernel/cpu/common=
=2Ec
>index c7d3512914ca=2E=2E71e89859dfb4 100644
>--- a/arch/x86/kernel/cpu/common=2Ec
>+++ b/arch/x86/kernel/cpu/common=2Ec
>@@ -401,6 +401,25 @@ static __always_inline void setup_umip(struct cpuinf=
o_x86 *c)
> 	cr4_clear_bits(X86_CR4_UMIP);
> }
>=20
>+static __always_inline void setup_lass(struct cpuinfo_x86 *c)
>+{
>+	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
>+		/*
>+		 * Legacy vsyscall page access causes a #GP when LASS is
>+		 * active=2E However, vsyscall emulation isn't supported
>+		 * with #GP=2E To avoid breaking userspace, disable LASS
>+		 * if the emulation code is compiled in=2E
>+		 */
>+		if (IS_ENABLED(CONFIG_X86_VSYSCALL_EMULATION)) {
>+			pr_info_once("x86/cpu: Disabling LASS due to CONFIG_X86_VSYSCALL_EMUL=
ATION=3Dy\n");
>+			setup_clear_cpu_cap(X86_FEATURE_LASS);
>+			return;
>+		}
>+
>+		cr4_set_bits(X86_CR4_LASS);
>+	}
>+}
>+
> /* These bits should not change their value after CPU init is finished=
=2E */
> static const unsigned long cr4_pinned_mask =3D X86_CR4_SMEP | X86_CR4_SM=
AP | X86_CR4_UMIP |
> 					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
>@@ -2011,10 +2030,10 @@ static void identify_cpu(struct cpuinfo_x86 *c)
> 	/* Disable the PN if appropriate */
> 	squash_the_stupid_serial_number(c);
>=20
>-	/* Set up SMEP/SMAP/UMIP */
> 	setup_smep(c);
> 	setup_smap(c);
> 	setup_umip(c);
>+	setup_lass(c);
>=20
> 	/* Enable FSGSBASE instructions if available=2E */
> 	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {

Legacy vsyscalls have been obsolete for how long now?


