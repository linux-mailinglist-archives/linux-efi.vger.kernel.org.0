Return-Path: <linux-efi+bounces-3462-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6F8A9C4F0
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 12:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910B01B833BB
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 10:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0702523D2A7;
	Fri, 25 Apr 2025 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXpIaVTc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1123236D;
	Fri, 25 Apr 2025 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575983; cv=none; b=htFQHbQ5aThto2HlMLaTDVnyFC096Unl3TjS7GvnfC3IUcEHjNy4diPKRmQ/LGZuh3d9m4ej36ODWAw0wjded8RawJCpXAERod3xFsyOnPMd/A/oc0pVLFGT+kAFSHIFqqn3LrPfpZZJhXWiO/F0A/xnUBTae17+VaYVnDICcQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575983; c=relaxed/simple;
	bh=Oho9zISwXumIwyreGzhuOMH64zT4cJky5KKcy9RQz80=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=ohE+OVj6kqQMULrnm3e2d/aGbkd3t1kOtfYlVoKGUZhQKcCVh6olcCz+lozfAu0L9OdmIN0q7JNAFGbrkvF9DfSpkK0i/WH5yrbUmf6cukI7RTirY751bB60gNbhCpGwiSb2OFipBwnx5+cIqxAqBuWT82B4pDm/wDhj6wDLEj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXpIaVTc; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5259327a937so843339e0c.0;
        Fri, 25 Apr 2025 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745575980; x=1746180780; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxUaPsRL3DayWO3frv2ULqEXQAoXMSOznD4LncXDA04=;
        b=nXpIaVTcHQg+xejDXFraR+p5ixEdobw/MxyybnrFVAOKhqCHqrRuqUlU4ed329FoMK
         +hRAuPOBToW2almIVxJYryAtY/lG4+QiiMJ5WnI102+7hxYtrXM2p2FSErZGKn31jXTN
         Vmti4obgp8qCZ+15/5SNnAreP69I0yTKxZ8lOyiXNjKhDdXS50YbhtDuFMEGWmu3HSJ3
         EG+Vs0QvQPF32tCaLucp/hyIV7W8tWtTme0tmAO+DHkTGm9yn1s20+srvrUtA6rr9z4F
         wwJ+QWRZ6Kfl8K68WpP6aSU3Khr4v6+mudBi7MGlcD8C1PqslS3qT7koQuXIdUhYrNAU
         Zh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745575980; x=1746180780;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NxUaPsRL3DayWO3frv2ULqEXQAoXMSOznD4LncXDA04=;
        b=lL7oCEWy+i98pG7Ix5NEV4+iDdtST2N+LoEtJULkBeHTcFC77frcIARUvq4JHG8Fhj
         0rIolRJu6HR6f5fPhiQvW4FZmyo9PF+AIfb2Eihfvzz+yZuCW9w8iYA+59WrOhCF+95H
         5OMPIwoBa2Sm5rMsgTVqzPNundda1lhx/aRciuNwuh4yGmPCaVjkLx7mYgkGtX2he22X
         Pw3ixqUs9tz0xyCPFEWrk2pQObkJMUp6czlGeywIu3uAOp/K2bfRs83JcrL2L0buoiZ9
         4WVAi+xdR3+z8Vh0wbEfbYAWpP5wAtBRlul8GEm20wUvFrzBanv3qAYG0N+4dE9qqUfy
         QnDA==
X-Forwarded-Encrypted: i=1; AJvYcCUhnWlBpAlZ5OslfyDRapDpsrijc7/sr+zWwXRf/q20o6tUbFss0LQcMP4BFPbWz25wAc9WdTsphERX@vger.kernel.org, AJvYcCVAwbChTAYJBRcx3EMCbwuYqzDM4U4wPsLS3UItX5mEF44qfp5IoYXfwUwIRoY29hVxwaCToTarjkLcCcfPD106@vger.kernel.org, AJvYcCWXCpgy2qwOo2kvg3NiO0Mi6OdprPxfSNlh/W0qAMceJc7koYZEl+2OY3FjdYgNOLG256hslQBhk7EWnxkS@vger.kernel.org, AJvYcCWtbipKP92Gt5ZGIT2MRy4yh6BAD9OjaclANgm4PQW0j1pChioNp0fJ3lM1MAeSBUyQUcaIoZxHd5iv@vger.kernel.org, AJvYcCX9DNjKz3WKt7iQZaGb4sZRLjocSqj0J9c2dWXMvI01tIf+9NXnteWL635j3Pggz83x+/ZzpU/fs7RaaV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIIxXgNV5NFsvERszZyDQ+9+g1oSed4p8CUckitMnrZPNoYZpA
	Fey9SJ+X/TosK97t3eA0eqjVu3yrenjjwwrN/yZUrNKmzo6BQUd9a4XNczKo
X-Gm-Gg: ASbGnctpd7dfrrvFLo+WoKxiQb/uoIW9A0SYBm2XWmXgylNgYYiF2LAbIRtmWKM3BNi
	nKzWLUWH0oHDQRn8DexbYZmHwH90Y6SDzMeM2RmaC7IBWZsVTtGhp8BKGlf/v33sAbiT3tkfEv+
	OEkhfPLSUqCiJyEAJiBL0h69Xm2Aw7DZps2vwi8rAhDJIQsXjZPXZVgnPGufxCrUpCPCdChWuun
	Ld9E1UdS6WZgWaX+CxCSAjSNsGfHUN/N0+CtRHvsnlBFk7qAukCkp2o908A7WmuksjCC6WHtthD
	qIuL3a+tqDFOk+7/3YILk0aObT/iBmnOs0EF/wSIn3KEkZgUCArQf5rvV0RPsZpY5yuYRNb6/el
	XXCPfLw9RAe6Y4oWs
X-Google-Smtp-Source: AGHT+IGiA/Yn603iCEcUZTepPAJSDOP4M4TDfO1zGDg1GjK6jBe0wK+uDj0rtvLjSeP4gVl0jlYXxQ==
X-Received: by 2002:a05:6122:da5:b0:50d:a31c:678c with SMTP id 71dfb90a1353d-52a89d3e399mr831693e0c.2.1745575980041;
        Fri, 25 Apr 2025 03:13:00 -0700 (PDT)
Received: from smtpclient.apple (216-131-82-239.nyc.as62651.net. [216.131.82.239])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52a79f21b86sm605458e0c.9.2025.04.25.03.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 03:12:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Rich Persaud <persaur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v14 00/19] x86: Trenchboot secure dynamic launch Linux kernel support
Message-Id: <18F9BD47-282D-4225-AB6B-FDA4AD52D7AE@gmail.com>
Date: Fri, 25 Apr 2025 06:12:46 -0400
Cc: Ross Philipson <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev,
 dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com,
 Sergii Dmytruk <sergii.dmytruk@3mdeb.com>, openxt@googlegroups.com
To: Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPad Mail (22E252)

=EF=BB=BFOn Apr 24, 2025, at 2:45=E2=80=AFPM, Dave Hansen <dave.hansen@intel=
.com> wrote:
> =EF=BB=BFOn 4/21/25 09:26, Ross Philipson wrote:
>> This patchset provides detailed documentation of DRTM, the approach used f=
or
>> adding the capbility, and relevant API/ABI documentation. In addition to t=
he
>> documentation the patch set introduces Intel TXT support as the first pla=
tform
>> for Linux Secure Launch.
>=20
> So, I know some of the story here thanks to Andy Cooper. But the
> elephant in the room is:
>=20
>> INTEL(R) TRUSTED EXECUTION TECHNOLOGY (TXT)
>> M:      Ning Sun <ning.sun@intel.com>
>> L:      tboot-devel@lists.sourceforge.net
>> S:      Supported
>> W:      http://tboot.sourceforge.net
>> T:      hg http://tboot.hg.sourceforge.net:8000/hgroot/tboot/tboot
>> F:      Documentation/arch/x86/intel_txt.rst
>> F:      arch/x86/kernel/tboot.c
>> F:      include/linux/tboot.h
>=20
> Linux already supports TXT. Why do we need TrenchBoot?

One reason is to generalize DRTM support to other platforms.

RFC: Trenchboot Secure Launch DRTM for AMD SKINIT=20
https://lore.kernel.org/lkml/cover.1734008878.git.sergii.dmytruk@3mdeb.com/

OpenXT.org measured launch usage of tboot originated in 2012, when I was the=
 program manager for XenClient joint development [1][2] by Intel and Citrix.=
 TrenchBoot was proposed in 2018 at Platform Security Summit and evolved [3]=
 based on LKML and conference feedback. The tboot community was introduced [=
4] to TrenchBoot in 2022.


> I think I know the answer, but it also needs to be a part of the
> documentation, changelogs and cover letter.
>=20
> Also, honestly, what do you think we should do with the Linux tboot
> code? Is everyone going to be moving over to Trenchboot

OpenXT will migrate development of measured launch from tboot to TrenchBoot S=
ecure Launch, after upstream Linux and Xen have support for both Intel and A=
MD DRTM. Previously-deployed Intel devices using tboot, derived from OpenXT,=
 will need support until users upgrade their hardware. Qubes is integrating [=
5] TrenchBoot into AEM (Anti Evil Maid). Since Oracle has spent several year=
s working on this TrenchBoot series, they might use it, hopefully they can c=
omment.=20


> so that Linux support for TXT/tboot can just go away?

[opinion]
Which one will prevail? That may have less to do with tboot-trenchboot diffe=
rences and more to do with AMD-Intel product marketing and OEM segmentation o=
f DRTM features, some certified by Microsoft as "Secured Core" clients with S=
MM attestation (Intel PPAM and AMD SMM Supervisor).

Intel requires client vPro devices for TXT, but has slowly expanded the list=
 of eligible SKUs via "vPro Essentials" segmentation. AMD SKINIT is present o=
n most processors, but DRTM currently requires a dTPM instead of the "mobile=
" fTPM implementation in AMD PSP firmware, with dTPMs mostly present in AMD O=
EM "PRO" or Embedded SKUs.

If AMD included the full TPM 2.0 reference code in their PSP fTPM,  or if MS=
 Pluton implemented a full TPM 2.0 that was compatible with DRTM, then the n=
umber of AMD DRTM-capable devices would be much higher than the number of In=
tel vPro or AMD PRO devices, expanding the market for DRTM-capable software l=
ike Linux (trenchboot) Secure Launch and Windows SystemGuard. That would inc=
rease client adoption of trenchboot, as the only option for Linux DRTM on AM=
D.

On servers, both AMD and Intel hardware support DRTM with dTPM and other roo=
ts of trust, but there are other launch considerations, including BMCs, SPDM=
 device attestation & vendor hypervisors.
[/opinion]

In a perfect world, Intel-signed ACM (used in TXT DRTM) binary blobs would b=
e accompanied by public read-only source code, with reproducible builds that=
 generate those ACM blobs. In that perfect world, Intel ACM and tboot develo=
pers would review the TrenchBoot Linux series, recommend improvements and gu=
ide customers on migration from tboot to upstream-supported Linux DRTM. Neit=
her has yet happened. Both would be welcome.

Rich


[1] https://www.intel.com/content/dam/www/public/us/en/documents/success-sto=
ries/3rd-gen-core-vpro-citrix-vendor-spotlight.pdf

[2] http://media12.connectedsocialmedia.com/intel/11/9510/Air_Force_Research=
_Laboratory_Security_Collaboration_Government.pdf

[3] https://trenchboot.org/events/

[4] https://sourceforge.net/p/tboot/mailman/message/37631560/

[5] https://blog.3mdeb.com/2023/2023-01-31-trenchboot-aem-for-qubesos/


