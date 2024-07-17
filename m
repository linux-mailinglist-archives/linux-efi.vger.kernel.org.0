Return-Path: <linux-efi+bounces-1453-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D84449343EC
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 23:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944162842ED
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 21:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8313A187327;
	Wed, 17 Jul 2024 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="mDHLBAc0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C201F95E;
	Wed, 17 Jul 2024 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251975; cv=none; b=s2MGBmiFvwFuuGATxN3uTv2dkC7BstcYbxk7is6ohVVWKoN0I/5IILAvgftOo/KvnSs8GGxGz8+2D3Z4lrEDpwRrb188XwJH0nUa0Dpnzvxetv0Y9JgwE7PdzhDyZHZCJQDA3mVsDD+2UtkXJ447TeLif9lDeaDWlP/ULex0CU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251975; c=relaxed/simple;
	bh=jAqASVbOGDrayX320WlZ2he6/a0Mqy/3Sa7ghz3Thgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k3oGQLxbas5Sg90QPKRz7EndVmMtFubop/fR+ogVUwUCGWx+w+xz4qoBL61jdjI5NkZxZa5eT9iH7TXaWLvdb1Cr25nKF+QVIPc0WLnjRILd2lbpItCZqrkGaRbFw+W/TmQqBqLnzASFLUFIm+PWsWTNUcJ90DqzNLlH0i+sau8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=mDHLBAc0; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HEofNS002946;
	Wed, 17 Jul 2024 21:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pps0720; bh=808SU6qyaK/Um857JBYO8r
	S2Bl8LCNVBrZBok6IKwwE=; b=mDHLBAc0rPzJ0DNjqfFEzkKXPo4oM8PhTOFKQ1
	HuJUpQPfnyug8cPcDiqB3fj0HwIx+r3ujhrK2eLvGBgL8/FwVPkrlvbtSEzdmqut
	/IRFW+T8imeLqrJyeYRDer2YKF75NpOuspGovuiqtAIPnO7Ff+3mZ2K5SA3XtjAs
	XWwmX5GDnPW/zAyR5EBRQEj/fT3K761hZyDuPw0wVg2f6dIb6oJnFR2+VNUpBt7E
	R8fAko62JGJApVURJAeq9UQzajzdqT3eGWfjUWUOpA8NJjV68QmbLlOxIv0jWmln
	cOESQm/SrX8LMrNjgd66POhuHiphUlW4pqPwvuYZ1IF/tPXA==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 40dwf02w6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 21:31:26 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id B9C1E80026E;
	Wed, 17 Jul 2024 21:31:24 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 71C0480FDCA;
	Wed, 17 Jul 2024 21:31:22 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id 36CDD300BB4C9; Wed, 17 Jul 2024 16:31:21 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>,
        Tao Liu <ltao@redhat.com>, kexec@lists.infradead.org,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH v3 0/2] Resolve problems with kexec identity mapping
Date: Wed, 17 Jul 2024 16:31:19 -0500
Message-Id: <20240717213121.3064030-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ho06VTQBQgjQyTsV5tShzxTP38dasqcr
X-Proofpoint-ORIG-GUID: ho06VTQBQgjQyTsV5tShzxTP38dasqcr
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_16,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=893
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170162

Creating kexec identity maps using only GB pages can include a lot of
extra address space past that requested, including areas marked
reserved by the BIOS, which on UV systems can cause system halts.

The previous attempt to fix this problem,

       7143c5f4cf20 ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")

caused a regression on a small number of AMD systems, and was later reverted.

The cause of this regression was that the EFI Config Table Array was
not explicitly included in the kexec identity map. While this array was
often included in the identity map by luck, when it was not, code that
checks whether the AMD SEV feature should be enabled takes a page
fault due to the array's address not being mapped.  This happens before
the new kernel is able to set up a page fault handler, so it is fatal.

The patch that was reverted greatly reduced the chance that the EFI
Config Table Array got mapped by luck, which is why this problem
appeared.  The kernel command line option "nogbpages" also causes the
problem to show, and was used for debugging and illustrative purposes.

The first patch in this series explicitly adds the EFI Config Table
array to the kexec identity map so this problem will not occur.

The second patch in the series re-instates the previously reverted
patch that reduces usage of gbpages in creating the identity map.

All three of the people who reported regression with my earlier patch
have retested with this patch series and found it to work where my
single patch previously did not.  With current kernels, all fail to
kexec when "nogbpages" is on the command line, but all succeed with
"nogbpages" after the series is applied.

Series version 3:
  * In patch 1, do not change name of map_efi_systab, and fix comment.

Series version 2:

  * Removed a patch (formerly #2) that also added the CC blob to the
    identity map, as this was proactive, but not proved necessary.

  * Rewrote this cover letter and patch commit messages to include
    discussion on previous version.

V1: https://lore.kernel.org/all/20240520183633.1457687-1-steve.wahl@hpe.com/

Steve Wahl (1):
  x86/mm/ident_map: Use gbpages only where full GB page should be
    mapped.

Tao Liu (1):
  x86/kexec: Add EFI config table identity mapping for kexec kernel

 arch/x86/kernel/machine_kexec_64.c | 27 +++++++++++++++++++++++++++
 arch/x86/mm/ident_map.c            | 23 ++++++++++++++++++-----
 2 files changed, 45 insertions(+), 5 deletions(-)

-- 
2.26.2


