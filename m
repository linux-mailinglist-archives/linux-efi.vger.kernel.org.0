Return-Path: <linux-efi+bounces-6207-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOIXGv3CnGnJKAQAu9opvQ
	(envelope-from <linux-efi+bounces-6207-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 22:13:33 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD38717D66E
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 22:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E7D307AA73
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 21:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B8837881C;
	Mon, 23 Feb 2026 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="a8PazJZj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8AF314B6A;
	Mon, 23 Feb 2026 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881210; cv=none; b=g4p/UeCNiC8i7pjcnDPwj+pjFhwpE/4I23dPqBUEm4uL8l7C3W5FE1M8SgWegjsiv56k5rbpjkRLPFGk3z3YnQkmnNbaQyh7zXIeleTYp/5DarK0sjKBux2GxLCQsVmUcLjzsPbnkkFmoZtTf/czTR0lRkBBuvIbu3t7Bbc8mK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881210; c=relaxed/simple;
	bh=FXWLsFBULN47oU6UnihHicv55DBHr+3HTf5qLu27+E8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNngwPX8ZexUwKsX75dDJ2TxTf0qZbztCFdSwJmwAU+2FjEflj1Cm6mfjZ012wTf5e3GMYzDJCCdr0q3gVWcsu4bUxUfCcORURbNOYS0SAx9e+4Ko3h3kcUEjfqoN00ySRnpsXBTJ3Ue3Dol7SCpynjzU/lsYvVCd0s90SpB7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=a8PazJZj; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1771881192; x=1772485992; i=deller@gmx.de;
	bh=RJf0nsljCI+i9g1LVWsmN8S0BjGbbwcRgx9+3Q3RHbw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=a8PazJZjG/Zr0HnSR181NIFhqvPsxm4+nm0uAq5rKQECgoXKr8+eGdYkVtUCRAxz
	 UBXzqrDnWr0Y15ZnLzkfHhkG8TBCPFDzD6dMYpUOYsgkadHubyFZfC+a8si5uY32I
	 oDedrp0LwCBukPGafutleaNe5Ej3nvmY9WqMw3LYl29Yme0DCo2ksQ/DTVvHZrvBh
	 RG50P4ixzzZwO6LhItn3lg/Ceu8bPZcE5gaLpE2RTwmQCYOtaVQu+OM7aL2zVQ8zz
	 AECjshx8UJLZ4Esd9Nzzt4q79gIsCCi8uuwHjJhXPPMop0rifMXwkOFWsoW4uNelE
	 cChB9a6if+cgGCgwNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.98]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof9F-1vNpeT1l4D-00fO4G; Mon, 23
 Feb 2026 22:13:12 +0100
Message-ID: <fe6b9a16-232b-4819-b978-95775791c197@gmx.de>
Date: Mon, 23 Feb 2026 22:13:10 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] kbuild: Switch from '-fms-extensions' to
 '-fms-anonymous-structs' when available
To: Ard Biesheuvel <ardb@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Kees Cook <kees@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-efi@vger.kernel.org, llvm@lists.linux.dev
References: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
 <9ba5bb34-2356-4c10-a3d3-f122abe1073b@app.fastmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <9ba5bb34-2356-4c10-a3d3-f122abe1073b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:edyU13fh/kMHHybT6GaqRMeq5qiPJzYGzoSP9IilU+H5UfLe2wQ
 oDiFn7ntb+Sc2C1oFkVuugZ3Yio0sM9opPmpbo5e/bfgfChIR2f38fiq3gyZQP4PwNxnp1A
 7RRRiLtZ/A9BTHEwih+bDa9/OBmP4fpdnVIX7px0BaxZqMOrjH/rG0WCmZItpSUUw938zf7
 Y/bYxXGufbN7sGvHlcpGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OX7zAu/9Gb8=;aoV7n9ivZnuEgRDXBlXSDAmx603
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6207-lists,linux-efi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[linux-foundation.org,arm.com,kernel.org,xen0n.name,hansenpartnership.com,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,alien8.de,linux.intel.com,zytor.com,linaro.org,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deller@gmx.de,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi,lkml];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD38717D66E
X-Rspamd-Action: no action

On 2/23/26 20:38, Ard Biesheuvel wrote:
>=20
>=20
> On Mon, 23 Feb 2026, at 20:10, Nathan Chancellor wrote:
>> Hi all,
>>
>> The kernel enabled '-fms-extensions' in commit c4781dc3d1cf ("Kbuild:
>> enable -fms-extensions") in 6.19 to gain access to a Microsoft
>> (originally Plan 9) extension around including a tagged structure/union
>> anonymously in an other structure/union. Since then, Clang 23.0.0
>> (current main) has added a flag to enable only that extension, rather
>> than all Microsoft extensions, '-fms-anonymous-structs' [1]. Using this
>> narrower compiler option would have avoided the build error fixed by
>> commit a6773e6932cb ("jfs: Rename _inline to avoid conflict with clang'=
s
>> '-fms-extensions'"). While these errors are not expected to be common,
>> using the narrower option when available has no drawbacks because the
>> kernel only cares about this extension in '-fms-extensions', no others.
>> While this could result in build errors for folks using
>> '-fms-anonymous-structs' if a developer uses another extension in
>> '-fms-extensions' (either intentionally or unintentionally), flagging
>> these uses for further scrutiny seems worthwhile.
>>
>> This series converts the build system to use that flag when it is
>> available. The first patch consolidates all of the C dialect flags into
>> a single variable to make future updates to the dialect flags less
>> painful, as updating the logic in every place that uses their custom
>> built C flags is getting cumbersome (and C23 is looming). The second
>> patch makes the actual switch.
>>
>> I would like Nicolas to carry this in the Kbuild tree for 7.1, please
>> provide Acks as necessary.
>>
>> [1]:
>> https://github.com/llvm/llvm-project/commit/c391efe6fb67329d8e2fd231692=
cc6b0ea902956
>>
>> ---
>> Nathan Chancellor (2):
>>        kbuild: Consolidate C dialect options
>>        kbuild: Use '-fms-anonymous-structs' if it is available
>>
>=20
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

For the series:
Acked-by: Helge Deller <deller@gmx.de>  # parisc

Thanks!
Helge

