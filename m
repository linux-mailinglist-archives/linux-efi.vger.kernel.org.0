Return-Path: <linux-efi+bounces-2232-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C68349DBB0F
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 17:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688CF2824EF
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087741BDA95;
	Thu, 28 Nov 2024 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="B2ViS2h1";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="v/YZypLf"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23C01BBBFC;
	Thu, 28 Nov 2024 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810424; cv=none; b=DlhqM2AqtDS3qJsxMMDeIEPGTrrreSv27zP3t5OqHwWaVbngkQvl0AzHi9DxZ49GFUIG/VMispY4yPeUPooEEz0dcSSuW/UwEcOq4cocTintU5sp1uEtZBECi6YsecPlfMdUjmPGudIv+bAKlX/Yax7HnLJZmOFY6OinapVN4Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810424; c=relaxed/simple;
	bh=36RM/emkzJ/MIiZRi6++IhibTmpT4u2A2dU4Wm0KqtI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZ5WeBWNPRybCURgUbFFUyHB4ZzM+1Qs2L0Gef/gYPt02KVLMkUmh+Lvr5E14XnpquKKTx06h4Mbzcc9zR3mMen7I3bN0J62S6wrYKb6mDnQ0lPab6c0v2/SBbQgSsffNti+l+/wLbS+JLtFJyQhIhzvnTTIKPLf0UsHE6embPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=B2ViS2h1; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=v/YZypLf; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1732810421;
	bh=36RM/emkzJ/MIiZRi6++IhibTmpT4u2A2dU4Wm0KqtI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=B2ViS2h1Q8ceNgF9QwGrxubGH1jiDLkp7lSY3Mv224jVa4CTOTdQToZYbUiqe9ZtR
	 90RBPurWcrX38jnqRBGROkMZ7hmlPXXODlEjUsRM33ixiB8P70bT4PEpSv1sqnrGAQ
	 lfXtV4Orgis2Fq7d6sDH8TXpNINrkeZFBImi8XNQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0B52A12802C1;
	Thu, 28 Nov 2024 11:13:41 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id FPDywFY1KpQE; Thu, 28 Nov 2024 11:13:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1732810420;
	bh=36RM/emkzJ/MIiZRi6++IhibTmpT4u2A2dU4Wm0KqtI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=v/YZypLfvfjYlu8Wx5Tyeg0x967MwV94e4SajZI0ivh0oCNSiNpgdotFoCJofa5ZB
	 rYewSxAfaLVPYKEH1J5mDr2y1VIZ1+Q4v+8TZpu/wLmYuHyElDGxy+10o/DncLp+PN
	 61dUAcjdtIOIGrkYw11usZ0uItS5qnTlg2fKD00g=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A99AD128014F;
	Thu, 28 Nov 2024 11:13:39 -0500 (EST)
Message-ID: <70bc83bd7cfb236da030e584e93bfc62c1d9eb6a.camel@HansenPartnership.com>
Subject: Re: TPM/EFI issue [Was: Linux 6.12]
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jiri Slaby <jirislaby@kernel.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>, Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>
Cc: Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>, Jarkko Sakkinen
	 <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"linux-efi@vger.kernel.org"
	 <linux-efi@vger.kernel.org>
Date: Thu, 28 Nov 2024 11:13:36 -0500
In-Reply-To: <2a238b61-fa03-4ae4-9dc4-f73834aa3228@kernel.org>
References: 
	<CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com>
	 <9c893c52-e960-4f30-98ce-ba7d873145bb@kernel.org>
	 <ca741d8eade72aa68c389a88d2520f4fe541a1e7.camel@HansenPartnership.com>
	 <2a238b61-fa03-4ae4-9dc4-f73834aa3228@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-11-28 at 08:20 +0100, Jiri Slaby wrote:
> On 27. 11. 24, 17:24, James Bottomley wrote:
[...]
> > Well, it looks like you eliminated the TPM changes:
> > 
> > https://bugzilla.suse.com/show_bug.cgi?id=1233752#c6
> > 
> > So it must be something in the logging or event recording code. 
> > The first thing to check is can you run a replay of the log to get
> > the end PCR values?  The binary for that is
> > 
> > tsseventextend -sim -v -if
> > /sys/kernel/security/tpm0/binary_bios_measurements
> 
> I put this into bbm (attached).
> 
> > You'll have to check the values it gives against the values in
> > 
> > /sys/class/tpm/tpm0/tpm-sha256
> 
> I have only /sys/class/tpm/tpm0/pcr-sha256/.
>    grep -H '.*' /sys/class/tpm/tpm0/pcr-sha256/*
> attached

Yes, sorry, typo as you figured out.

> 
> With that:
>  > $ for aa in /sys/class/tpm/tpm0/pcr-sha256/*; do sha=`cat $aa`;
> echo 
> === $sha; if [[ ! $sha =~ [F0]{64} ]]; then sha=$(echo $sha | sed
> 's@..@ 
> &@g'); grep -i "$sha" bbm; fi; done
> > ===
> > 6C26A8BB35548545A189FFFC421134BE14D94B5E16DB91BA9628CBF67C69DDDA
> >  PCR 00: 6c 26 a8 bb 35 54 85 45 a1 89 ff fc 42 11 34 be 14 d9 4b
> > 5e 16 db 91 ba 96 28 cb f6 7c 69 dd da 
> > ===
> > 9967D57B20DE03689395042372515F2B91A6ADAC4042B5E0139B44A21FB36F7D
> >  PCR 01: 99 67 d5 7b 20 de 03 68 93 95 04 23 72 51 5f 2b 91 a6 ad
> > ac 40 42 b5 e0 13 9b 44 a2 1f b3 6f 7d 
> > ===
> > 002651E9DD78325EFFBC4AE276401522575216280406A0DDA2D41AE8CA2EE3DC
> > ===
> > 0000000000000000000000000000000000000000000000000000000000000000
> > ===
> > 76E6D50D860B4CBAF4552CBFD4A83309F6DD855040657531DA796A386318CEAA
> > ===
> > 0000000000000000000000000000000000000000000000000000000000000000
> > ===
> > 30EFACACDAC53DEA877ED268648596776B212A4FF556D9B7FF934BEC5702EDD8
> >  PCR 14: 30 ef ac ac da c5 3d ea 87 7e d2 68 64 85 96 77 6b 21 2a
> > 4f f5 56 d9 b7 ff 93 4b ec 57 02 ed d8 
> > ===
> > 0000000000000000000000000000000000000000000000000000000000000000
> > ===
> > 0000000000000000000000000000000000000000000000000000000000000000
> > ===
> > FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
> > ===
> > FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
> > ===
> > FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
> > ===
> > C83EA442D306E65267328CC6DA4B539A8F7216C329E90E0AAE5527026E50637D
> >  PCR 02: c8 3e a4 42 d3 06 e6 52 67 32 8c c6 da 4b 53 9a 8f 72 16
> > c3 29 e9 0e 0a ae 55 27 02 6e 50 63 7d 
> > ===
> > FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
> > ===
> > FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
> > ===
> > FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
> > ===
> > 0000000000000000000000000000000000000000000000000000000000000000
> > ===
> > 3D458CFE55CC03EA1F443F1562BEEC8DF51C75E14A9FCF9A7234A13F198E7969
> >  PCR 03: 3d 45 8c fe 55 cc 03 ea 1f 44 3f 15 62 be ec 8d f5 1c 75
> > e1 4a 9f cf 9a 72 34 a1 3f 19 8e 79 69 
> >  PCR 06: 3d 45 8c fe 55 cc 03 ea 1f 44 3f 15 62 be ec 8d f5 1c 75
> > e1 4a 9f cf 9a 72 34 a1 3f 19 8e 79 69 
> > ===
> > 8C5ED4D1866768D7CDEC958584CA4FD9FA94D419EAE0BDEBB4284CF33A82CD9F
> >  PCR 04: 8c 5e d4 d1 86 67 68 d7 cd ec 95 85 84 ca 4f d9 fa 94 d4
> > 19 ea e0 bd eb b4 28 4c f3 3a 82 cd 9f 
> > ===
> > 0AC36B8B8CBD577A01949D77146BAB421E7111A8530DECCB4AC6A4899BD22740
> >  PCR 05: 0a c3 6b 8b 8c bd 57 7a 01 94 9d 77 14 6b ab 42 1e 71 11
> > a8 53 0d ec cb 4a c6 a4 89 9b d2 27 40 
> > ===
> > 3D458CFE55CC03EA1F443F1562BEEC8DF51C75E14A9FCF9A7234A13F198E7969
> >  PCR 03: 3d 45 8c fe 55 cc 03 ea 1f 44 3f 15 62 be ec 8d f5 1c 75
> > e1 4a 9f cf 9a 72 34 a1 3f 19 8e 79 69 
> >  PCR 06: 3d 45 8c fe 55 cc 03 ea 1f 44 3f 15 62 be ec 8d f5 1c 75
> > e1 4a 9f cf 9a 72 34 a1 3f 19 8e 79 69 
> > ===
> > 6508BC9385D1E735BAC5C87D870962270D5134F4F49ECFFF01ECDC5B4EAD9A56
> >  PCR 07: 65 08 bc 93 85 d1 e7 35 ba c5 c8 7d 87 09 62 27 0d 51 34
> > f4 f4 9e cf ff 01 ec dc 5b 4e ad 9a 56 
> > ===
> > 0000000000000000000000000000000000000000000000000000000000000000
> > ===
> > F5A2E8762B524BE1CCAFE763672BC31627C326A1470A9DC351566F2413FDEFC2
> 
> 
> > Probably also check sha1 to see if it matches.
> 
> > for aa in /sys/class/tpm/tpm0/pcr-sha1/*; do sha=`cat $aa`; echo
> > === $sha; if [[ ! $sha =~ [F0]{32} ]]; then sha=$(echo $sha | sed
> > 's@..@ &@g'); grep -i "$sha" bbm; fi; done
> > === A4399CFC6A5FD20EC6697913936CBEE35B8353C4
> >  PCR 00: a4 39 9c fc 6a 5f d2 0e c6 69 79 13 93 6c be e3 5b 83 53
> > c4 
> > === 24F81DFF31EE374162E759B0395247ADC7A6FFB8
> >  PCR 01: 24 f8 1d ff 31 ee 37 41 62 e7 59 b0 39 52 47 ad c7 a6 ff
> > b8 
> > === 466B2B859CA97E60AEAADFD279A689E534D0CE7B
> > === 0000000000000000000000000000000000000000
> > === 485E52A350F34D1EF4263C1E2C99D22A771C4C01
> > === 0000000000000000000000000000000000000000
> > === 87F3655072D45EA768F02ADB16EF946D42620224
> >  PCR 14: 87 f3 65 50 72 d4 5e a7 68 f0 2a db 16 ef 94 6d 42 62 02
> > 24 
> > === 0000000000000000000000000000000000000000
> > === 0000000000000000000000000000000000000000
> > === FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
> > === FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
> > === FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
> > === DCFFB00B36562803DDE211D6E07C2D7F123279E3
> >  PCR 02: dc ff b0 0b 36 56 28 03 dd e2 11 d6 e0 7c 2d 7f 12 32 79
> > e3 
> > === FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
> > === FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
> > === FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
> > === 0000000000000000000000000000000000000000
> > === B2A83B0EBF2F8374299A5B2BDFC31EA955AD7236
> >  PCR 03: b2 a8 3b 0e bf 2f 83 74 29 9a 5b 2b df c3 1e a9 55 ad 72
> > 36 
> >  PCR 06: b2 a8 3b 0e bf 2f 83 74 29 9a 5b 2b df c3 1e a9 55 ad 72
> > 36 
> > === DCD4E77C33E164FCC8F3D566AE83840F8265E47D
> >  PCR 04: dc d4 e7 7c 33 e1 64 fc c8 f3 d5 66 ae 83 84 0f 82 65 e4
> > 7d 
> > === 35871F5AFB0129A9535C35B6BF82A3DF075E124B
> >  PCR 05: 35 87 1f 5a fb 01 29 a9 53 5c 35 b6 bf 82 a3 df 07 5e 12
> > 4b 
> > === B2A83B0EBF2F8374299A5B2BDFC31EA955AD7236
> >  PCR 03: b2 a8 3b 0e bf 2f 83 74 29 9a 5b 2b df c3 1e a9 55 ad 72
> > 36 
> >  PCR 06: b2 a8 3b 0e bf 2f 83 74 29 9a 5b 2b df c3 1e a9 55 ad 72
> > 36 
> > === 16F5D0A8B980EC71DAFAD1E515554482747A4FCE
> >  PCR 07: 16 f5 d0 a8 b9 80 ec 71 da fa d1 e5 15 55 44 82 74 7a 4f
> > ce 
> > === 0000000000000000000000000000000000000000
> > === 8482CFF5AE0D9217ABB8BB82EAC487136DAFFC96
> 
> I have no idea if this tells you anything :).

Yes, it tells me the entries in the log for PCR0-7,14 match the log
entries (for both sha1 and sha256).  However there are entries for
PCR9,12 which don't match.  The log shows shim starting at entry 32,
grub starting at entry 37 and the kernel loading at entry 39  the
kernel command line logged at 40 to PCR 12, which is mismatching.

The next two entries (41,42) are for the mismatching PCR9 and are of
the initrd and the options and come from the libstub code in the kernel
early boot (efi-stub-helper.c).  This code was last updated in 6.9, so
it seems unlikely to have suddenly caused a problem.  Event 43,44 are
exit boot services (logged to PCR 5 which matches).

line 40 is anomalous: grub is supposed to measure the options to the
string PCR which should be 8 not 12 ... did you patch grub to change
this?  The log can't be corrupt because PCR8 is zero, so nothing got
logged to it.

And do you have the same thing for a working system?

Regards,

James


