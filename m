Return-Path: <linux-efi+bounces-1697-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AB6973D97
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 18:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A21E287A50
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245D1755C;
	Tue, 10 Sep 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="frhRX/Ru"
X-Original-To: linux-efi@vger.kernel.org
Received: from ma-mailsvcp-mx-lapp03.apple.com (ma-mailsvcp-mx-lapp03.apple.com [17.32.222.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2711A0718
	for <linux-efi@vger.kernel.org>; Tue, 10 Sep 2024 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.32.222.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986725; cv=none; b=kXF3ampYbHoFYzNZAppR70uNBjtWFHU1CMja5heHmGm9H//F6f9EtnRtF1JIWF3Gy+SDc6H5tWRJjgo/AMJ5gdgOzWtVVMXAqfBu84DvcZjfejHdlE7lZrvyHIgr0GMb1TcNZfO42004Cdvbw58Boa1zji2Ja96ZzPLJpfRzrDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986725; c=relaxed/simple;
	bh=P27R41PukbdRF3Yev7N3i7hMblzc97GWNrnAQCAeA6M=;
	h=Content-type:MIME-version:Subject:From:In-reply-to:Date:Cc:
	 Message-id:References:To; b=etXrTCAI+NZVyt5Dz3W1aJmJ9QetJnQUReqiSwmdW98cPXkwFUVEEdwbhsafsNqIaMJHF0yRal720ggDfdVjZbQT0B3Jthow9vhAMIXyWy3c8Rp3hQYIqDSxZMF4ia3hkquIFjYdnogUgXjD/d9AQ6n1CJSxCr9beHaFm1n6fQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=frhRX/Ru; arc=none smtp.client-ip=17.32.222.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by ma-mailsvcp-mx-lapp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SJL00RFST2PN430@ma-mailsvcp-mx-lapp03.apple.com> for
 linux-efi@vger.kernel.org; Tue, 10 Sep 2024 08:44:54 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_04,2024-09-09_02,2024-09-02_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=20180706;
 bh=kUOJZ7tUncMAJzkdVFaOCPtKthzEaNpQ7rDNkyZ+1Wc=;
 b=frhRX/RuST2AmW2DzT6mZuezJf/y9aGo3gTGB3mIdaIKjLug8HOZ2PkfQDuZ/q9a+w3R
 Zw49iuTowacbVsj8Cz1Gp6kpI25YR2FeE11z9QyHDitpje5wwvaeaCRtMopl42fLRmr6
 Ba6lC14fQVSCSuc9Dx5QmPNJXFKYcPkeqaloXlvzhiQ9I+/3OFZtHSORh5BguQMhZbeZ
 INw8/XIAJY/qdMu10ISiixB7PIsIrr186qa52PdrP1T0BeiZSWxHJfYJ9RcgLNRppRGP
 3uFTxdlI3i6opRhMVPc53jYb6BFMQ2soALt/CKymktcMqaV8A9cF7h82leD2tEj2Gl9N gA==
Received: from mr55p01nt-mmpp01.apple.com
 (mr55p01nt-mmpp01.apple.com [10.170.185.219])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SJL00RP2T2R82P0@rn-mailsvcp-mta-lapp03.rno.apple.com>;
 Tue, 10 Sep 2024 08:44:52 -0700 (PDT)
Received: from process_milters-daemon.mr55p01nt-mmpp01.apple.com by
 mr55p01nt-mmpp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SJL0VP00T1AQK00@mr55p01nt-mmpp01.apple.com>; Tue,
 10 Sep 2024 15:44:51 +0000 (GMT)
X-Va-A:
X-Va-T-CD: 4c3984f1f823aa50c40fcb2a43cca4c1
X-Va-E-CD: c40cdd13cd530915072e8c6f5b81c115
X-Va-R-CD: cb226b3d113575e0c7ead9a62b61fc48
X-Va-ID: 90868364-5703-4c93-92da-456d47eec033
X-Va-CD: 0
X-V-A:
X-V-T-CD: 4c3984f1f823aa50c40fcb2a43cca4c1
X-V-E-CD: c40cdd13cd530915072e8c6f5b81c115
X-V-R-CD: cb226b3d113575e0c7ead9a62b61fc48
X-V-ID: 923be45a-1c50-47dd-afa8-a23aa1b228b2
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_04,2024-09-09_02,2024-09-02_01
Received: from smtpclient.apple (unknown [17.11.88.207])
 by mr55p01nt-mmpp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPSA id <0SJL0V0AXT2QG900@mr55p01nt-mmpp01.apple.com>; Tue,
 10 Sep 2024 15:44:51 +0000 (GMT)
Content-type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [edk2-devel] EFI table being corrupted during Kexec
From: "Andrew (EFI) Fish" <afish@apple.com>
In-reply-to: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
Date: Tue, 10 Sep 2024 08:44:40 -0700
Cc: ardb@kernel.org, linux-efi@vger.kernel.org, kexec@lists.infradead.org,
 bhe@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com, rppt@kernel.org,
 usamaarif642@gmail.com, gourry@gourry.net, rmikey@meta.com
Content-transfer-encoding: quoted-printable
Message-id: <BABE4F07-DF49-48C5-BAB7-B5986C035C8E@apple.com>
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
To: devel@edk2.groups.io, leitao@debian.org
X-Mailer: Apple Mail (2.3818.100.11.1.3)



> On Sep 10, 2024, at 6:58=E2=80=AFAM, Breno Leitao <leitao@debian.org> =
wrote:
>=20
>=20
> We've seen a problem in upstream kernel kexec, where a EFI TPM log =
event table
> is being overwritten.  This problem happen on real machine, as well as =
in a
> recent EDK2 qemu VM.
>=20
> Digging deep, the table is being overwritten during kexec, more =
precisely when
> relocating kernel (relocate_kernel() function).
>=20
> I've also found that the table is being properly reserved using
> memblock_reserve() early in the boot, and that range gets overwritten =
later in
> by relocate_kernel(). In other words, kexec is overwriting a memory =
that was
> previously reserved (as memblock_reserve()).
>=20
> Usama found that kexec only honours memory reservations from =
/sys/firmware/memmap
> which comes from e820_table_firmware table.
>=20

The E820 table is not part of the UEFI standard and it is produced by a =
library in the OvmfPkg for =E2=80=9Cspecial cases=E2=80=9D so I guess =
that lib could have a bug?

> Looking at the TPM spec, I found the following part:
>=20
> 	If the ACPI TPM2 table contains the address and size of the =
Platform Firmware TCG log,
> 	firmware =E2=80=9Cpins=E2=80=9D the memory associated with the =
Platform Firmware TCG log, and reports
> 	this memory as =E2=80=9CReserved=E2=80=9D memory via the INT =
15h/E820 interface.
>=20

INT 15h is Legacy BIOS not UEFI. For UEFI there is just the UEFI memory =
map and ACPI.=20

Thanks,

Andrew Fish


>=20
> From: =
https://trustedcomputinggroup.org/wp-content/uploads/PC-ClientPlatform_Pro=
file_for_TPM_2p0_Systems_v49_161114_public-review.pdf
>=20
> I am wondering if that memory region/range should be part of e820 =
table that is
> passed by EFI firmware to kernel, and if it is not passed (as it is =
not being
> passed today), then the kernel doesn't need to respect it, and it is =
free to
> overwrite (as it does today). In other words, this is a firmware bug =
and not a
> kernel bug.
>=20
> Am I missing something?
>=20
> Thanks
> --breno
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#120541): =
https://edk2.groups.io/g/devel/message/120541
> Mute This Topic: https://groups.io/mt/108376671/1755084
> Group Owner: devel+owner@edk2.groups.io
> Unsubscribe: https://edk2.groups.io/g/devel/unsub [afish@apple.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20


