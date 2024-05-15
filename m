Return-Path: <linux-efi+bounces-1038-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D828C6BDA
	for <lists+linux-efi@lfdr.de>; Wed, 15 May 2024 20:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8209B211DC
	for <lists+linux-efi@lfdr.de>; Wed, 15 May 2024 18:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7BA158DA9;
	Wed, 15 May 2024 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="fru98BVI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BB9158845;
	Wed, 15 May 2024 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796327; cv=none; b=JuwNcGlRPTb1uVePeO4u4OmvZaEQ3dzwnhIJ0y0uxaq7ozoANk06Ehsl9+PGFZ0ExHyIuh/YmuNgg0mBOqTjSkQVt+U+vhrdPMCMEXZmdNESY+ZQfbPxrAwrfG1FhCA0rPg5UleiSKLxWWgfOFnQ7tlHdrNXxu/yiDag5FuVrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796327; c=relaxed/simple;
	bh=NOWeMdSAMU8+1sNAkP8Nr6iomJ7DvwEXpGNc1eKDk9Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OcV7nxzdvIan6z7EVg2W0X3V9jjvA7KFnMOWZVcWNekrk75Ada4uOukraqohxkt7NbtkwqeLOGrk9diCil4RUWYHzbks31hXSkDYPIK66VKaHZSH4dIIlansdgluCjy+gUxH5ENQbnWtM/VD2Ho6o/uHmqEf4a9a8REgvNohzSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=fru98BVI; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44F9vZnB018902;
	Wed, 15 May 2024 18:32:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
	from:to:cc:subject:date:message-id:content-type:content-id
	:content-transfer-encoding:mime-version; s=jan2016.eng; bh=NOWeM
	dSAMU8+1sNAkP8Nr6iomJ7DvwEXpGNc1eKDk9Q=; b=fru98BVI8LqPFgxPVZr0T
	UpEDpwuLFY0WCgmofI7PZbh5AzTAte7ft1TRxW7a1P33qdEgpF9d4KDN6CdCEUGS
	VBk5Kkl4uHUX8dYl4R4q375W2oGwBYvovyRY3p0cOc7IwN0xjQPBY7Hh9wpiUm2m
	5oxYMpT8thcwz+rcU4Yuy9vMyCldMi8VMK50O7U+WDXuATLLxxMcuSL+JDXPVzak
	LbLQqODiBelzl7e3Khk1RtAlV2BKA1/2ds5IXk/uPc8VC3w6l8ZksrnOYqlNNfGa
	DVazoQ3VH2H6r/YfAQ2I7VXdOSyQL1ciO6H9EUk1B4EHzCH7dusP/U92F9+GpN/Q
	w==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 3y20b56v7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 18:32:28 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 44FCjiDj026173;
	Wed, 15 May 2024 13:32:27 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.27])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 3y240y4u9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 13:32:27 -0400
Received: from usma1ex-dag4mb1.msg.corp.akamai.com (172.27.91.20) by
 usma1ex-dag4mb8.msg.corp.akamai.com (172.27.91.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 15 May 2024 13:32:27 -0400
Received: from usma1ex-dag4mb1.msg.corp.akamai.com ([172.27.91.20]) by
 usma1ex-dag4mb1.msg.corp.akamai.com ([172.27.91.20]) with mapi id
 15.02.1258.028; Wed, 15 May 2024 13:32:27 -0400
From: "Chaney, Ben" <bchaney@akamai.com>
To: "ardb@kernel.org" <ardb@kernel.org>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Tottenham, Max"
	<mtottenh@akamai.com>,
        "Hunt, Joshua" <johunt@akamai.com>,
        "Galaxy, Michael"
	<mgalaxy@akamai.com>
Subject: Regression in 6.1.81: Missing memory in pmem device
Thread-Topic: Regression in 6.1.81: Missing memory in pmem device
Thread-Index: AQHapu3aAXNBspXH5EmfViMgDx95dw==
Date: Wed, 15 May 2024 17:32:27 +0000
Message-ID: <FA5F6719-8824-4B04-803E-82990E65E627@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D238261143F6D46B9677A1E174E540D@akamai.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_10,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=598
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150122
X-Proofpoint-ORIG-GUID: 2KyqGTvCdGd3uUwnnZ2PZHER5km1icai
X-Proofpoint-GUID: 2KyqGTvCdGd3uUwnnZ2PZHER5km1icai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_10,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 bulkscore=0 suspectscore=0 mlxlogscore=434 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405150124

SGVsbG8sDQogICAgICAgICAgICAgICAgSSBlbmNvdW50ZXJlZCBhbiBpc3N1ZSB3aGVuIHVwZ3Jh
ZGluZyB0byA2LjEuODkgZnJvbSA2LjEuNzcuIFRoaXMgdXBncmFkZSBjYXVzZWQgYSBicmVha2Fn
ZSBpbiBlbXVsYXRlZCBwZXJzaXN0ZW50IG1lbW9yeS4gU2lnbmlmaWNhbnQgYW1vdW50cyBvZiBt
ZW1vcnkgYXJlIG1pc3NpbmcgZnJvbSBhIHBtZW0gZGV2aWNlOg0KDQpmZGlzayAtbCAvZGV2L3Bt
ZW0qDQpEaXNrIC9kZXYvcG1lbTA6IDM1NS45IEdpQiwgMzgyMTE3ODcxNjE2IGJ5dGVzLCA3NDYz
MjM5Njggc2VjdG9ycw0KVW5pdHM6IHNlY3RvcnMgb2YgMSAqIDUxMiA9IDUxMiBieXRlcw0KU2Vj
dG9yIHNpemUgKGxvZ2ljYWwvcGh5c2ljYWwpOiA1MTIgYnl0ZXMgLyA0MDk2IGJ5dGVzDQpJL08g
c2l6ZSAobWluaW11bS9vcHRpbWFsKTogNDA5NiBieXRlcyAvIDQwOTYgYnl0ZXMNCg0KRGlzayAv
ZGV2L3BtZW0xOiAyNS4zOCBHaUIsIDI3MjQ2MTk4Nzg0IGJ5dGVzLCA1MzIxNTIzMiBzZWN0b3Jz
DQpVbml0czogc2VjdG9ycyBvZiAxICogNTEyID0gNTEyIGJ5dGVzDQpTZWN0b3Igc2l6ZSAobG9n
aWNhbC9waHlzaWNhbCk6IDUxMiBieXRlcyAvIDQwOTYgYnl0ZXMNCkkvTyBzaXplIChtaW5pbXVt
L29wdGltYWwpOiA0MDk2IGJ5dGVzIC8gNDA5NiBieXRlcw0KDQoJVGhlIG1lbW1hcCBwYXJhbWV0
ZXIgdGhhdCBjcmVhdGVkIHRoZXNlIHBtZW0gZGV2aWNlcyBpcyDigJxtZW1tYXA9MzY0NDE2TSEy
ODY3Mk0sMzY3NDg4TSE0MTk4NDBN4oCdLCB3aGljaCBzaG91bGQgY2F1c2UgYSBtdWNoIGxhcmdl
ciBhbW91bnQgb2YgbWVtb3J5IHRvIGJlIGFsbG9jYXRlZCB0byAvZGV2L3BtZW0xLiBUaGUgYW1v
dW50IG9mIG1pc3NpbmcgbWVtb3J5IGFuZCB0aGUgZGV2aWNlIGl0IGlzIG1pc3NpbmcgZnJvbSBp
cyByYW5kb21pemVkIG9uIGVhY2ggcmVib290LiBUaGVyZSBpcyBzb21lIGFtb3VudCBvZiBtZW1v
cnkgbWlzc2luZyBpbiBhbG1vc3QgYWxsIGNhc2VzLCBidXQgbm90IDEwMCUgb2YgdGhlIHRpbWUu
IE5vdGFibHksIHRoZSBtZW1vcnkgdGhhdCBpcyBtaXNzaW5nIGZyb20gdGhlc2UgZGV2aWNlcyBp
cyBub3QgcmVjbGFpbWVkIGJ5IHRoZSBzeXN0ZW0gZm9yIGdlbmVyYWwgdXNlLiBUaGlzIHN5c3Rl
bSBpbiBxdWVzdGlvbiBoYXMgNzY4R0Igb2YgbWVtb3J5IHNwbGl0IGV2ZW5seSBhY3Jvc3MgdHdv
IE5VTUEgbm9kZXMuDQoNCglXaGVuIHRoZSBlcnJvciBvY2N1cnMsIHRoZXJlIGFyZSBhbHNvIHRo
ZSBmb2xsb3dpbmcgZXJyb3IgbWVzc2FnZXMgc2hvd2luZyB1cCBpbiBkbWVzZzoNCg0KWyAgICA1
LjMxODMxN10gbmRfcG1lbSBuYW1lc3BhY2UxLjA6IFttZW0gMHg1YzIwNDJjMDAwLTB4NWZmN2Zm
ZmZmZiBmbGFncyAweDIwMF0gbWlzYWxpZ25lZCwgdW5hYmxlIHRvIG1hcA0KWyAgICA1LjMzNTA3
M10gbmRfcG1lbTogcHJvYmUgb2YgbmFtZXNwYWNlMS4wIGZhaWxlZCB3aXRoIGVycm9yIC05NQ0K
DQoJQmlzZWN0aW9uIGltcGxpY2F0ZXMgMmRmYWVhYzNmMzhlNGU1NTBkMjE1MjA0ZWVkZDk3YTA2
MWZkYzExOCBhcyB0aGUgcGF0Y2ggdGhhdCBmaXJzdCBjYXVzZWQgdGhlIGlzc3VlLiBJIGJlbGll
dmUgdGhlIGNhdXNlIG9mIHRoZSBpc3N1ZSBpcyB0aGF0IHRoZSBFRkkgc3R1YiBpcyByYW5kb21p
emluZyB0aGUgbG9jYXRpb24gb2YgdGhlIGRlY29tcHJlc3NlZCBrZXJuZWwgd2l0aG91dCBhY2Nv
dW50aW5nIGZvciB0aGUgbWVtb3J5IG1hcCwgYW5kIGl0IGlzIGNsb2JiZXJpbmcgc29tZSBvZiB0
aGUgbWVtb3J5IHRoYXQgaGFzIGJlZW4gcmVzZXJ2ZWQgZm9yIHBtZW0uDQoNClRoYW5rIHlvdSwN
CglCZW4gQ2hhbmV5DQoNCg0KDQoNCg==

