Return-Path: <linux-efi+bounces-5033-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4675BD25B5
	for <lists+linux-efi@lfdr.de>; Mon, 13 Oct 2025 11:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C82644E9C8B
	for <lists+linux-efi@lfdr.de>; Mon, 13 Oct 2025 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41B5222596;
	Mon, 13 Oct 2025 09:46:25 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2A7199BC;
	Mon, 13 Oct 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348785; cv=none; b=ZKCgohd1xL19kixfG5QrAAQTQsAlE+fPxOdf1iFUPhDTxRMP+H1UWUTHFowl8+eaEd4jdqGZ66gGJOlEJRg41uDsCb0lpjWJ0Q61j5AnQgJdQH6yzkvE1n539nqqttWeoL1rynpELkW2uVhK6N/26cr2gSnyxHEs6qhikkyW2WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348785; c=relaxed/simple;
	bh=h823Jn7znHP8KA7iEsFvYpJbceJefEHuZ7L/AHM4m44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E0/jSMM/Yziq3F3+pCWpOmtexpBCaeRfy/2tox6FCiOt3egpCD++PEsFtKIVfnCYIRSdoH6XMssHHcCKXLpmqjEqlE9Q+sWw/kEmsgKADRWTnSrg5ituAAbDnA6AS/OUSje2Xw4q2AR5xTHlGAYDRjF+zQGrR3NT5hkSCa/UbhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4clXQm0fRsz1r5T4;
	Mon, 13 Oct 2025 11:40:47 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4clXQl0TLcz1qqlS;
	Mon, 13 Oct 2025 11:40:47 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 96rRaL0Kr7Gj; Mon, 13 Oct 2025 11:40:37 +0200 (CEST)
X-Auth-Info: TXi3Ra51dtUNS+v1oT8VzPM2f29+Ppei3QKG18ckJuVai8AeeR6PaC9Ckxly1rws
Received: from igel.home (aftr-82-135-83-44.dynamic.mnet-online.de [82.135.83.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Mon, 13 Oct 2025 11:40:37 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 631152C19F8; Mon, 13 Oct 2025 11:40:37 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org,  linux-efi@vger.kernel.org,
  x86@kernel.org,  Ard Biesheuvel <ardb@kernel.org>,  Borislav Petkov
 <bp@alien8.de>,  Ingo Molnar <mingo@kernel.org>,  Kevin Loughlin
 <kevinloughlin@google.com>,  Tom Lendacky <thomas.lendacky@amd.com>,  Josh
 Poimboeuf <jpoimboe@kernel.org>,  Peter Zijlstra <peterz@infradead.org>,
  Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v7 15/22] objtool: Add action to check for absence of
 absolute relocations
In-Reply-To: <20250828102202.1849035-39-ardb+git@google.com> (Ard Biesheuvel's
	message of "Thu, 28 Aug 2025 12:22:18 +0200")
References: <20250828102202.1849035-24-ardb+git@google.com>
	<20250828102202.1849035-39-ardb+git@google.com>
Date: Mon, 13 Oct 2025 11:40:37 +0200
Message-ID: <87cy6rf8bu.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Aug 28 2025, Ard Biesheuvel wrote:

> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 79eab61cd944..aeefc749e237 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -4686,6 +4686,47 @@ static void disas_warned_funcs(struct objtool_file *file)
>  		disas_funcs(funcs);
>  }
>  
> +__weak bool arch_absolute_reloc(struct elf *elf, struct reloc *reloc)
> +{
> +	unsigned int type = reloc_type(reloc);
> +	size_t sz = elf_addr_size(elf);
> +
> +	return (sz == 8) ? (type == R_ABS64) : (type == R_ABS32);
> +}
> +
> +static int check_abs_references(struct objtool_file *file)
> +{
> +	struct section *sec;
> +	struct reloc *reloc;
> +	int ret = 0;
> +
> +	for_each_sec(file, sec) {
> +		/* absolute references in non-loadable sections are fine */
> +		if (!(sec->sh.sh_flags & SHF_ALLOC))
> +			continue;
> +
> +		/* section must have an associated .rela section */
> +		if (!sec->rsec)
> +			continue;
> +
> +		/*
> +		 * Special case for compiler generated metadata that is not
> +		 * consumed until after boot.
> +		 */
> +		if (!strcmp(sec->name, "__patchable_function_entries"))
> +			continue;
> +
> +		for_each_reloc(sec->rsec, reloc) {
> +			if (arch_absolute_reloc(file->elf, reloc)) {
> +				WARN("section %s has absolute relocation at offset 0x%lx",
> +				     sec->name, reloc_offset(reloc));

This is wrong for a 32-bit host:

In file included from check.c:16:
check.c: In function ‘check_abs_references’:
/home/andreas/src/linux/linux-6.18-rc1/tools/objtool/include/objtool/warn.h:47:3: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 7 has type ‘u64’ {aka ‘long long unsigned int’} [-Werror=format=]
   47 |   "%s%s%s: objtool" extra ": " format "\n",  \
      |   ^~~~~~~~~~~~~~~~~
/home/andreas/src/linux/linux-6.18-rc1/tools/objtool/include/objtool/warn.h:54:2: note: in expansion of macro ‘___WARN’
   54 |  ___WARN(severity, "", format, ##__VA_ARGS__)
      |  ^~~~~~~
/home/andreas/src/linux/linux-6.18-rc1/tools/objtool/include/objtool/warn.h:74:27: note: in expansion of macro ‘__WARN’
   74 | #define WARN(format, ...) __WARN(WARN_STR, format, ##__VA_ARGS__)
      |                           ^~~~~~
check.c:4713:5: note: in expansion of macro ‘WARN’
 4713 |     WARN("section %s has absolute relocation at offset 0x%lx",
      |     ^~~~
cc1: all warnings being treated as errors

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

