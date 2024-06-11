Return-Path: <linux-efi+bounces-1200-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D34903F10
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2024 16:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14744B25139
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2024 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98A317DE01;
	Tue, 11 Jun 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jxpVuDZe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C7yKFOBN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97BA5336D;
	Tue, 11 Jun 2024 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117091; cv=fail; b=DM5wjW6NJERXP1yIdt6zFmKdFXVEsJMYWt5l5X9yViO87MEgGtXoHcgRZy8/D8ZUVEOHy66qjzvbOTMtk/Nq98UkkCdOCFV2ry9qiSluxbwa3I5KL10/D/KFrwPCLBPVMWTfeLELEjw9dUS6emNazPK+Tk1hiVFnpYR81NbcP/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117091; c=relaxed/simple;
	bh=5GmAU2TmTcNC47xyuoTM71tsAyrsPKMll4zKJZ80c/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L6R3c+QFWr6AmjiQ0B8e3Gand/tWQiMDwhJZHl38t07bhD0+4u7j/qPoW1v+Ff2O0F3gtduMJ1VdRCMayb+gRxG3ihSCbgHrjOM82m8tdu4uMZoFrflTwCym2ZyQOtuZl+5KCuduUj/4ngExhGlUiR1ezMIHXI02VJfGsGHiae4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jxpVuDZe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C7yKFOBN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B7fRDj013404;
	Tue, 11 Jun 2024 14:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=5GmAU2TmTcNC47xyuoTM71tsAyrsPKMll4zKJZ80c
	/4=; b=jxpVuDZen0XnvMtcmFkCPCojCUD4L3vafApdy4YBqIFIYrvnoFZeECJF7
	+GaWryoQN9GwvZjKjTimrQf/Se0EgtLuSV0FuqiTEFYwuVFRhLf050eQm66tYD3x
	CoSY5wu6AC91cePKG6hhTPUfiT+JcBO7mwukXJY4b0abBiGl8PCCzvesNXrioLOA
	eCzKIseszVMlXa8HADVCMIDRJZoE/CiSURFGASCLUuesusXwCN3KtDZqEtFBRwFW
	X3SM6INAvRC4ZGB9Q1rcF9MghiTYbRuFFBwyJyiL85ZaApbWVGiVamwTdCBqDrlT
	ctvfMHnos9yT2r70EBCziFH0X8jkg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7fmxn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 14:36:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BEM8fa012556;
	Tue, 11 Jun 2024 14:36:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync9wxsk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 14:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Im/H0ujCh7ZRuGdaWNDFbsuUr+Jv6W6lSsMX26RiRBBeLh4fkXDQoqIOxMTSQo05Zp38Q/VVS7SxOybnJ0kpBVEYw2eLMdF7q5BfVVTDyr95oPHfcwrvTuW8kcuZEakFkaf4yChKc2atKBRup8WQ+m2ii9WbTJRi9TRVEXw1y/eVRaJIcxpFX62Us4oKUVeURO87v7vyU1LRAgeKu+it7Ve4eUeAM6DT/SbsYn4hIf0n6/teJ8xje3mMnLWussMlvBQZQwo7piVYrLdlR8MJQ0853bXp1lwNTaLIHkeKZ0MBPFxJE7p2AKcIG5NRJKKjgD4FXRK9tgbSbSM6K57/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GmAU2TmTcNC47xyuoTM71tsAyrsPKMll4zKJZ80c/4=;
 b=ZXHl1XmLqpnA6I9Qj4al47QyDrxzZcFbAUhD6GKfaXUmNG3JTZR83OI1T6FwqWQIzqTQQLwnB9OUo7XsDQkrg7xtfbm21nQp+f4hoFfiZ2+a1MI8JcVRAhTGE0djL4y+/sbutW6Nqo1P94+01snwsebAPFuo1UWIIbuWyskXAtu47tE5v35iky2ILoOqYJgRH91tP/JsmmpInV8jRadqDtZU+FrywKUUSh2pm+6bA3JPS9z6lWIrDT1OE6LttS649qXsiuLSQ4hx6ZokyV7RSHm/yLeu8xz+40pcWA9V/256AI40X27yvSQ//LUIFdbYOZcU3HISNtuzLEUUvQZ5xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GmAU2TmTcNC47xyuoTM71tsAyrsPKMll4zKJZ80c/4=;
 b=C7yKFOBNbOnfJlgy8Z9UW7uQBY7BTBmYUq4YbJrzWiWmQ8g26dg2mwKpm0XnHOs8kohsUJlJuySXY9v2JtMkrUkYPX+dQJFUHudq04rLRvvvHS1H+RhkED3HlCu8H1uGbQy3tnTVsQ17xHC1vRQ4X79fs2YuvuqrpXUaeKIzwsc=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MW4PR10MB5774.namprd10.prod.outlook.com (2603:10b6:303:18e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 14:36:27 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a%4]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 14:36:27 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Randy Dunlap <rdunlap@infradead.org>
CC: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel
	<ardb@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
	<serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu
	<roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        Stefan Berger
	<stefanb@linux.ibm.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        open
 list <linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>,
        "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH v2 8/8] clavis: Introduce new LSM called clavis
Thread-Topic: [RFC PATCH v2 8/8] clavis: Introduce new LSM called clavis
Thread-Index: AQHasvMfEYuY8yxvA0+2J/4ejcRyFbHB6YcAgADKAQA=
Date: Tue, 11 Jun 2024 14:36:26 +0000
Message-ID: <A607E53F-96EF-42BD-A438-FA07C111BEFF@oracle.com>
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
 <20240531003945.44594-9-eric.snowberg@oracle.com>
 <754d54b0-5848-4775-a989-43b75dac4dbf@infradead.org>
In-Reply-To: <754d54b0-5848-4775-a989-43b75dac4dbf@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|MW4PR10MB5774:EE_
x-ms-office365-filtering-correlation-id: 71885ecf-961b-46ec-1e65-08dc8a23e033
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?N1ZYRDFXOFlDa0VyTmNiUUk1MEtmcGJaYnJwSm5Nbjk3WmZTNjRBRXF2bVRm?=
 =?utf-8?B?b1Y1ci9WYldNVGdKaUN0VGZidS9ybjN2aEIvMFhmTjVDS2pZdTJoL0Qwb3hX?=
 =?utf-8?B?YWhSeUhCNkl1Nk15VjdDQzBFVU5qVFJaTHUyc2dPaVk3UDN3cS9hb0J1RDhB?=
 =?utf-8?B?SlI0OW9iQmg4UjJnM1RSVzZmL01CV2liZ01jc21FaXE3TUpMeGtPYmkxRmVL?=
 =?utf-8?B?bk1RRnpkVkNzWTc4cHp5VFdrR0N5anduUU5mM2t0enBsWTgzZWYvUExWd2VO?=
 =?utf-8?B?RUFJUkpwSWdqUU8xUW5VRFRDMW85MHo0WXFkN2RJN2dNckV5TDl6cFd0SVIr?=
 =?utf-8?B?cVlscU51MW9sbVdBMXY5dkhjUUN3Z1EzSXVmRHNhVWdvdUlCZTMyaXdDRFRM?=
 =?utf-8?B?U25RQi9ER010Y2ZLRDZud0UxdkZObmF2OHg5QWxBRmp1UVBmL2dvbTdLclVi?=
 =?utf-8?B?eHk4VGlST1l5N1FzOXlLL2VKMHVpVWxUWlR0ZDN5eFcxWFhVTGt0NXRScDI1?=
 =?utf-8?B?Z2NRa29kSFFPSTFxQmErSGJ3VmJZckl1NGRHY2lKb01NTXRXTUhIV3VqMENV?=
 =?utf-8?B?T0pEWVNJZk02ZmdrWC9obXBOL1M1U3REUkFlK29CSU5HVEVSZFdEZ3JLSFZ1?=
 =?utf-8?B?TDFlbVNuRTQwa3JudnI3VVQzaXczb2pCU3ZJejNRZWUzanJ1ZHNHYVprZERX?=
 =?utf-8?B?QS81R3NzeFRMblBQd3p3VzhDWWwzWC9Ua2pXYzkvRGd3cWdUNzNvZ1NGMEVP?=
 =?utf-8?B?OFZxZC9jUDFLcGNzeHlBRjhrYVJneVFoWkpTVWhEbVYxVzFtQitGSnBaWnNa?=
 =?utf-8?B?d1J5dGR6aFhWMm5SUXFjN2xPVGVLVjJ2VDYzemJhNktKVVFEMS84emhiYTJ5?=
 =?utf-8?B?UUQ0U29SUVI1Vjh6RmgxZC9sdFFjUU0vQmxLZTNWTDZnKzBiY0Npd1JUTXRC?=
 =?utf-8?B?cGlLOGZDa2ozUEdvWVFHSHVwMWlibEpWM29ubEdiL1ZJbTJIZnVQdTdhK0gr?=
 =?utf-8?B?ZGxnTGsyQk9RS1o1S1V1V1JPK0tVWFF0cDZOeWVWZWNVcFI3aDVvRDJIVlpj?=
 =?utf-8?B?clBoTEhJa2MzS0gzR1hadDhsZC8vaEdDdkpKWDduRkxUUjluSkpuVldiYjQv?=
 =?utf-8?B?Y1hvWWQzM2xKdUZtdFM4cXUyWkNvWlErczJzQUpKclRRY21mcU9weUp2bU5U?=
 =?utf-8?B?T09zejFqaG0xcFRLbnJlYnFEUTdBbmE3bFBYMHVkOTQ3cFdyRTM2d216bTVr?=
 =?utf-8?B?YURJS3loMjF1bUxYbkdmMzR1T0JWK2lobHI0Y0VUS09ETTdoZ2xzUCtxeWRL?=
 =?utf-8?B?MmdtU3NuUXFLc2ljS3VIU1B4bTVNWHpsK3VhdGNNeTNpYTdmMzNsdGZ3TXV4?=
 =?utf-8?B?QmljMDg0LzJoSjdZTkNSWXRhQlpiVzJWSjhrekRjS3dkL1JhckxSWU83YStP?=
 =?utf-8?B?SUdZazlFeDVPUjVYVCtmS1VGWEZob1J3VlpXT0cvUVg2YTdTRlJJQUhpVFRk?=
 =?utf-8?B?MktkTkJSamJUdXFSaGRUbmZmRnhUaXozRUVLc0lYWFYrRnBuTDVHUUc1SHRW?=
 =?utf-8?B?czNkT1N1TkwrYy8vM3Z1OVl0SlpvU0VxWjVXQkVmSjYyY2d0NnJDbGQzc2ZW?=
 =?utf-8?B?N2dsYU4yYkdOclNSVUwxT2lQNk9pVU5BV3ZlNW5UcXg4UVNacm9pL0pBSzRO?=
 =?utf-8?B?MmI3dm5LZkxEZGdzVFNoaFluWXM1alF1S0lWNkg0Q0VGWENYNHYraTF3aXJG?=
 =?utf-8?B?WG9VWHBlc05Ya21HQUFnZjJsRGdiU3BBczJkaUxBUVZnY21ucHRXNEJxNkJZ?=
 =?utf-8?Q?JlsHMiOqJZAwfDG43abGtCFOsiJ3K1tOLIMdc=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NHhQVVF4UkI0aFo2VEE5V2hWMUVSL3FEVVBrTytiVDNTTDk5TXBRRWlDS0dw?=
 =?utf-8?B?QTBCSWdTSXFVMC9wVllSeFVsQzg1N3RuVUhYZ1kzNlRDRVVHdWxaQVdHU0tx?=
 =?utf-8?B?TlhDNmYxUzFNOHB4SW1yNlZCaVBPa3Z5VytWV0tMSDBFb1V6T1oyRmdLZyty?=
 =?utf-8?B?blhMVjRHRC9NQWZBeHA4VU42OFMxRnBmbldDSWtLV1JQM1FXWHNEVmt6Zk1J?=
 =?utf-8?B?eFRpZVFVZVE0U2tUK3BhMXdlN3p2T3lmMUJ0S2liNWZFN0N1QytWOXRMNG9k?=
 =?utf-8?B?bGV6UzcyaEdLN2NMVjRDcHMzaVRDSDZwOHE0ZERSOTVSS2cwM3AwTkMzQ2s3?=
 =?utf-8?B?akMxcXpVUHhnbkpmK1B1ZmZ3Z1F6VWpDZ3lqSytjaG5EbE5reTZCVGxxbWZk?=
 =?utf-8?B?ZlNsQUtsSFpDaThldTJHWWh0RXZ0bExzSVZxM1E3S3YxNDQ4bWVscHFMOGJN?=
 =?utf-8?B?UVhieExQMkVObVFaTmN2SDZUenpvTm5hSCtmek5rYTRjYnJyMFJtYnZJcmMz?=
 =?utf-8?B?YzgwbkZnOGJVdkdicWpIZWZTb1B3RGJjVENRamtxenRaSnRmZTVCdHlzVnRu?=
 =?utf-8?B?bWs3TnlSenVkbEt3QTdQZk5jdVFBQ0Z6bGtqamFzSEpkdkVYakRuOTdqWnVJ?=
 =?utf-8?B?cnV2eGRmdHVHelFRWGdUSSs4QW5TeUZ6MXA4WVBTcG1wMld3a2w4WWowV2tS?=
 =?utf-8?B?eXFHQ01abUdoQ0hmRGhUakJkYndHTitQNjhIU1grM2RKQ3VHUlM3QWNzdHhS?=
 =?utf-8?B?RVZFSGZXbjdRUHNXTmxEU1BIL2R4VnRIY2p4aEEwQ3RTbkpTSzZMWmNuNmR5?=
 =?utf-8?B?dURjT2FIVUZTM1JqbnRZWnNFR242SG5Ec2xVTTZvbjdWWHdKZ3ppR3RDcUJH?=
 =?utf-8?B?RWxGdG9NY2g2TUhmNklVWWdsSlo5Q2VzTThoL1owbXRTWDlNQnI3citNalpx?=
 =?utf-8?B?cWRHL0pGQ1ZtL1VvTVB5RTdqWVJjZ0ZjaDVJTytmWGpKWWRCT25oSmVySFRv?=
 =?utf-8?B?MDlYQm5vZXRTYlZPZVk1RU5aUFZYRm5SWklGc1hZMWVRanIzSHQwWWJIUHJK?=
 =?utf-8?B?elk1dGNTZ3A1U3NvRXlzYmRQck1nQWh4K2FhMjhvVGdLSWExTktNWUE2ZzQ1?=
 =?utf-8?B?U0gxSFlwcHlhOUFoYXpJbEVGZEx6cjZ0UFZZZ3R3VElZdGk0ckwvTE1vcFpP?=
 =?utf-8?B?V3RxemQ0aXdhbGVSY1cvYzlXQTRFRFV1czR2UW51VDBpR0lDbkJVa2ZrOEFn?=
 =?utf-8?B?MUVJUDM4V3RYcnh3amJ2ZFVUTGJCaEZxVENLQnpOL1RCTzF6MStoQ3l0bUpT?=
 =?utf-8?B?ZEczTDZMOG9BaThjTE5LSHJJbXd4UEdJbVhLdld2aHYyNnVsMEdmOG9RS0R0?=
 =?utf-8?B?YlBobG14a3BDbkttb3JnbWpRRTVCSzZ0a1pDY1BQdGJ1NmVrb2w2dVlQSGN4?=
 =?utf-8?B?bFpvZ3JNVE5RaXRRa2d2SDhNQktIblBPenFRTlN4b3dLa0FBL0FreVh2MWZ6?=
 =?utf-8?B?OHIyaDFCR0xuM3lDUy9kTnU0YlMvaG95RVA4cW41WkFzTE8yYnF2cmVhQjVx?=
 =?utf-8?B?VEpHN2h0Q1BJeUJzUGFLNmRnOFpLMm41dFhWcUo4QTAyYSsrdDliVVgvOXNk?=
 =?utf-8?B?VUlqWUY3b2F3dVlPbzYyWFV0bzNER0NweHRZNmVCcG03M3g1OWdFb1VwNmZR?=
 =?utf-8?B?bjlPUVNGcUpKWlVVcFF3Q3BOT0RQdjNzUGlLL0JWRzF1NktUSnA5a2ErVlNm?=
 =?utf-8?B?dFRzaEVVZHBaVlRIVHpKM3NiYWQ1L0NrS1FFdWNnN3l3UkxoNWxvUUwyQ2pP?=
 =?utf-8?B?MmVLSkplKzFXNmJTaFFUeHNPTGptRm1RWkg0VUJ3NkU0U3FkV3BtbXZBZXM1?=
 =?utf-8?B?SWd1czl0dDRtSWdlalBVQVZZZTU1dU1BekphRklkTHQ2WEFiVGFpcUJmbXhj?=
 =?utf-8?B?aUZaa3VjNHh0OVltbzdwcVJpakNRM25YZzdodnp0SlA3M2lYVTBqOGR4YVNx?=
 =?utf-8?B?N1k4ZmMxb2xyaDNFamlvSmhWYkdQbnJuMGZWSkdKM0EvNHB3elV0bFdpS3Nu?=
 =?utf-8?B?NHk0eHBpWVBKOGtHcWVjZXdHelRLYnREU2w0OEc5QXZpQzNoOHk5TVdOeitu?=
 =?utf-8?B?KytRZ1BJTzRrU3UvSmNYYVR5bFJORkdiZ1VvK0R6b2RxOFF4R3NZZUFaM2Jm?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CC86E4603DB764A919F77A72F0A6D5B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pIe5+XnduzQ7tB6OHt6NniiOkYCiOfd1P3UJaj2BCjEvlmubyo5/zqmp/skQdf0sAa0/vYsncutmhCvxOtDxh4fzCOnqx0VkXW8s9wjB4Y/n/xuLKzLRq1s8WVtFgOXo6O9PIlQFZC0RcgGDR17Wmyr7U1o+eoACQ5vhed/qL92geLwGwAIhLOOKXe/ih0PCrPGmKjp9zCGalMU320ChUSfNUpAaWNd6mK1SwgK+GvJmsYW433Boq4ZgI+tRCn1honPBVdrgoYjUfu9OPlwOw3pEYA4ll51f3TMyIshYrwLq9c+BIk+pRnbcUJPTul647OzWztl7uzKodtS4TlgBk/DHifbmkQmrZzW7g0wk0tWOtr4ky0JiFhd3VocWHOyjtDVxl5DrG+gyknU3D2ZFsBndrW2/nEyAQBbUtIE9NeT15yN/uVuWYkHSHc1FsjXzBX49nXzF+pRk2mGNQnR89ZdBG8/IEfezMNyYOKlM3BcpuRWi25pNhhL7XOtJhIdB7rVXYcAXfDvf8iwhHfLokjkKJuBO4u+nmZEAaMWqPO0H5Q1JFiKdFCJCj9ZZo8DdGMCEFVR/Se2Psvr7qpXyG+cA83cgbAEoCl0AXdwuxqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71885ecf-961b-46ec-1e65-08dc8a23e033
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 14:36:26.9298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8VSKUzQS0UDdRLbejBNEVUB/oi2ittDQ2GoTAQVJ0oCDeWQ1Qwrldo9GXkYwpLv7zylyLa+VidpLxJRcfxBsCjCtg1QQKT1cIAHzNFH7lHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_07,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110105
X-Proofpoint-GUID: tRh6vsWPiLqr87PgX8S-r4V5ewtZUJHM
X-Proofpoint-ORIG-GUID: tRh6vsWPiLqr87PgX8S-r4V5ewtZUJHM

DQoNCj4gT24gSnVuIDEwLCAyMDI0LCBhdCA4OjMz4oCvUE0sIFJhbmR5IER1bmxhcCA8cmR1bmxh
cEBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IEhpIEVyaWMsDQo+IA0KPiBPbiA1LzMwLzI0
IDU6MzkgUE0sIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEVy
aWMgU25vd2JlcmcgPGVyaWMuc25vd2JlcmdAb3JhY2xlLmNvbT4NCj4+IC0tLQ0KPj4gRG9jdW1l
bnRhdGlvbi9hZG1pbi1ndWlkZS9MU00vY2xhdmlzLnJzdCB8IDE5OCArKysrKysrKysrKysrKysr
KysrKysrKw0KPj4gTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
NyArDQo+PiBjcnlwdG8vYXN5bW1ldHJpY19rZXlzL3NpZ25hdHVyZS5jICAgICAgIHwgICA0ICsN
Cj4+IGluY2x1ZGUvbGludXgvbHNtX2hvb2tfZGVmcy5oICAgICAgICAgICAgfCAgIDIgKw0KPj4g
aW5jbHVkZS9saW51eC9zZWN1cml0eS5oICAgICAgICAgICAgICAgICB8ICAgNyArDQo+PiBpbmNs
dWRlL3VhcGkvbGludXgvbHNtLmggICAgICAgICAgICAgICAgIHwgICAxICsNCj4+IHNlY3VyaXR5
L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKy0NCj4+IHNlY3VyaXR5L2Ns
YXZpcy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPj4gc2VjdXJpdHkvY2xhdmlz
L2NsYXZpcy5jICAgICAgICAgICAgICAgICB8ICAyNSArKysNCj4+IHNlY3VyaXR5L2NsYXZpcy9j
bGF2aXMuaCAgICAgICAgICAgICAgICAgfCAgIDQgKw0KPj4gc2VjdXJpdHkvY2xhdmlzL2NsYXZp
c19rZXlyaW5nLmMgICAgICAgICB8ICA4MyArKysrKysrKysrDQo+PiBzZWN1cml0eS9zZWN1cml0
eS5jICAgICAgICAgICAgICAgICAgICAgIHwgIDE2ICstDQo+PiAxMiBmaWxlcyBjaGFuZ2VkLCAz
NTIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL0xTTS9jbGF2aXMucnN0DQo+PiBjcmVhdGUgbW9kZSAx
MDA2NDQgc2VjdXJpdHkvY2xhdmlzL2NsYXZpcy5jDQo+PiANCj4+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2FkbWluLWd1aWRlL0xTTS9jbGF2aXMucnN0IGIvRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9MU00vY2xhdmlzLnJzdA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4
IDAwMDAwMDAwMDAwMC4uZDE2NDFlM2VmMzhiDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9E
b2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL0xTTS9jbGF2aXMucnN0DQo+PiBAQCAtMCwwICsxLDE5
OCBAQA0KPj4gKy4uIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+PiArDQo+PiAr
PT09PT09DQo+PiArQ2xhdmlzDQo+PiArPT09PT09DQo+PiArDQo+PiArQ2xhdmlzIGlzIGEgTGlu
dXggU2VjdXJpdHkgTW9kdWxlIHRoYXQgcHJvdmlkZXMgbWFuZGF0b3J5IGFjY2VzcyBjb250cm9s
IHRvDQo+PiArc3lzdGVtIGtlcm5lbCBrZXlzIChpLmUuIGJ1aWx0aW4sIHNlY29uZGFyeSwgbWFj
aGluZSBhbmQgcGxhdGZvcm0pLiBUaGVzZQ0KPj4gK3Jlc3RyaWN0aW9ucyB3aWxsIHByb2hpYml0
IGtleXMgZnJvbSBiZWluZyB1c2VkIGZvciB2YWxpZGF0aW9uLiBVcG9uIGJvb3QsIHRoZQ0KPj4g
K0NsYXZpcyBMU00gaXMgcHJvdmlkZWQgYSBrZXkgaWQgYXMgYSBib290IHBhcmFtLiAgVGhpcyBz
aW5nbGUga2V5IGlzIHRoZW4NCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJvb3QgcGFyYW1ldGVyLg0KPiANCj4+ICt1c2VkIGFzIHRoZSByb290IG9mIHRydXN0
IGZvciBhbnkgYWNjZXNzIGNvbnRyb2wgbW9kaWZpY2F0aW9ucyBtYWRlIGdvaW5nDQo+PiArZm9y
d2FyZC4gQWNjZXNzIGNvbnRyb2wgdXBkYXRlcyBtdXN0IGJlIHNpZ25lZCBhbmQgdmFsaWRhdGVk
IGJ5IHRoaXMga2V5Lg0KPj4gKw0KPj4gK0NsYXZpcyBoYXMgaXRzIG93biBrZXlyaW5nLiAgQWxs
IEFDTCB1cGRhdGVzIGFyZSBhcHBsaWVkIHRocm91Z2ggdGhpcyBrZXlyaW5nLg0KPj4gK1RoZSB1
cGRhdGUgbXVzdCBiZSBzaWduZWQgYnkgdGhlIHNpbmdsZSByb290IG9mIHRydXN0IGtleS4NCj4+
ICsNCj4+ICtXaGVuIGVuYWJsZWQsIGFsbCBzeXN0ZW0ga2V5cyBhcmUgcHJvaGliaXRlZCBmcm9t
IGJlaW5nIHVzZWQgdW50aWwgYW4gQUNMIGlzDQo+PiArYWRkZWQgZm9yIHRoZW0uIFRoZXJlIGlz
IHR3byBleGNlcHRpb25zIHRvIHRoaXMgcnVsZSwgYnVpbHRpbiBrZXlzIG1heSBiZSB1c2VkDQo+
IA0KPiAgICAgICAgICAgICAgICAgICBUaGVyZSBhcmUgICAgICAgICAgICAgICAgICAgICAgIHJ1
bGU6DQo+IA0KPiANCj4+ICt0byB2YWxpZGF0ZSBib3RoIHNpZ25lZCBrZXJuZWxzIGFuZCBtb2R1
bGVzLg0KPj4gKw0KPj4gK0FkZGluZyBzeXN0ZW0ga2VybmVsIGtleXMgY2FuIG9ubHkgYmUgcGVy
Zm9ybWVkIGJ5IHRoZSBtYWNoaW5lIG93bmVyOyB0aGlzDQo+PiArY291bGQgYmUgdGhyb3VnaCB0
aGUgTWFjaGluZSBPd25lciBLZXkgKE1PSykgb3IgdGhlIFVFRkkgU2VjdXJlIEJvb3QgREIuIEl0
DQo+PiAraXMgcG9zc2libGUgdGhlIG1hY2hpbmUgb3duZXIgYW5kIHN5c3RlbSBhZG1pbmlzdHJh
dG9yIG1heSBiZSBkaWZmZXJlbnQNCj4+ICtwZW9wbGUuIFRoZSBzeXN0ZW0gYWRtaW5pc3RyYXRv
ciB3aWxsIG5vdCBiZSBhYmxlIHRvIG1ha2UgQUNMIHVwZGF0ZXMgd2l0aG91dA0KPj4gK3RoZW0g
YmVpbmcgc2lnbmVkIGJ5IHRoZSBtYWNoaW5lIG93bmVyLg0KPj4gKw0KPj4gK09uIFVFRkkgcGxh
dGZvcm1zLCB0aGUgcm9vdCBvZiB0cnVzdCBrZXkgc2hhbGwgc3Vydml2ZSBhIGtleGVjLiBUcnlp
bmcgdG8NCj4+ICtkZWZlYXQgb3IgY2hhbmdlIGl0IGZyb20gdGhlIGNvbW1hbmQgbGluZSBpcyBu
b3QgYWxsb3dlZC4gIFRoZSBvcmlnaW5hbCBib290DQo+PiArcGFyYW0gaXMgc3RvcmVkIGluIFVF
RkkgYW5kIHdpbGwgYWx3YXlzIGJlIHJlZmVyZW5jZWQgZm9sbG93aW5nIGEga2V4ZWMuDQo+IA0K
PiAgIHBhcmFtZXRlcg0KPiANCj4+ICsNCj4+ICtUaGUgQ2xhdmlzIExTTSBjb250YWlucyBhIHN5
c3RlbSBrZXlyaW5nIGNhbGwgLmNsYXZpcy4gIEl0IGNvbnRhaW5zIGEgc2luZ2xlDQo+PiArYXN5
bW1ldHJpYyBrZXkgdGhhdCBpcyB1c2UgdG8gdmFsaWRhdGUgYW55dGhpbmcgYWRkZWQgdG8gaXQu
ICBUaGlzIGtleSBjYW4gb25seQ0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgIHVzZWQN
Cj4gDQo+PiArYmUgYWRkZWQgZHVyaW5nIGJvb3QgYW5kIG11c3QgYmUgYSBwcmVleGlzdGluZyBz
eXN0ZW0ga2VybmVsIGtleS4gIElmIHRoZQ0KPj4gK2BgY2xhdmlzPWBgIGJvb3QgcGFyYW0gaXMg
bm90IHVzZWQsIHRoZSBrZXlyaW5nIGRvZXMgbm90IGV4aXN0IGFuZCB0aGUgZmVhdHVyZQ0KPiAN
Cj4gICAgICAgICAgICAgICAgICAgIHBhcmFtZXRlcg0KPiANCj4+ICtjYW4gbm90IGJlIHVzZWQg
dW50aWwgdGhlIG5leHQgcmVib290Lg0KPiANCj4gICBjYW5ub3QNCj4gcHJlZmVyYWJseQ0KPiAN
Cj4+ICsNCj4+ICtUaGUgb25seSB1c2VyIHNwYWNlIGNvbXBvbmVudHMgYXJlIE9wZW5TU0wgYW5k
IHRoZSBrZXljdGwgdXRpbGl0eS4gQSBuZXcNCj4+ICtrZXkgdHlwZSBjYWxsIGBgY2xhdmlzX2tl
eV9hY2xgYCBpcyB1c2VkIGZvciBBQ0wgdXBkYXRlcy4gQW55IG51bWJlciBvZiBzaWduZWQNCj4+
ICtgYGNsYXZpc19rZXlfYWNsYGAgZW50cmllcyBtYXkgYmUgYWRkZWQgdG8gdGhlIC5jbGF2aXMg
a2V5cmluZy4gVGhlDQo+PiArYGBjbGF2aXNfa2V5X2FjbGBgIGNvbnRhaW5zIHRoZSBzdWJqZWN0
IGtleSBpZGVudGlmaWVyIGFsb25nIHdpdGggdGhlIGFsbG93ZWQNCj4+ICt1c2FnZSB0eXBlIGZv
cg0KPj4gK3RoZSBrZXkuDQo+IA0KPiBKb2luIDIgbGluZXM/DQo+IA0KPj4gKw0KPj4gK1RoZSBm
b3JtYXQgaXMgYXMgZm9sbG93czoNCj4+ICsNCj4+ICsuLiBjb2RlLWJsb2NrOjogY29uc29sZQ0K
Pj4gKw0KPj4gKyAgWFg6WVlZWVlZWVlZWVkNCj4+ICsNCj4+ICsgIFhYIC0gU2luZ2xlIGJ5dGUg
b2YgdGhlIGtleSB0eXBlDQo+PiArIFZFUklGWUlOR19NT0RVTEVfU0lHTkFUVVJFICAgICAgICAg
ICAgMDANCj4+ICsgVkVSSUZZSU5HX0ZJUk1XQVJFX1NJR05BVFVSRSAgICAgICAgICAwMQ0KPj4g
KyBWRVJJRllJTkdfS0VYRUNfUEVfU0lHTkFUVVJFICAgICAgICAgIDAyDQo+PiArIFZFUklGWUlO
R19LRVlfU0lHTkFUVVJFICAgICAgICAgICAgICAgMDMNCj4+ICsgVkVSSUZZSU5HX0tFWV9TRUxG
X1NJR05BVFVSRSAgICAgICAgICAwNA0KPj4gKyBWRVJJRllJTkdfVU5TUEVDSUZJRURfU0lHTkFU
VVJFICAgICAgIDA1DQo+PiArICA6ICAtIEFTQ0lJIGNvbG9uDQo+PiArICBZWSAtIEV2ZW4gbnVt
YmVyIG9mIGhleGFkZWNpbWFsIGNoYXJhY3RlcnMgcmVwcmVzZW50aW5nIHRoZSBrZXkgaWQNCj4+
ICsNCj4+ICtUaGUgYGBjbGF2aXNfa2V5X2FjbGBgIG11c3QgYmUgUy9NSU1FIHNpZ25lZCBieSB0
aGUgc29sZSBhc3ltbWV0cmljIGtleSBjb250YWluZWQNCj4+ICt3aXRoaW4gdGhlIC5jbGF2aXMg
a2V5cmluZy4NCj4+ICsNCj4+ICtJbiB0aGUgZnV0dXJlIGlmIG5ldyBmZWF0dXJlcyBhcmUgYWRk
ZWQsIG5ldyBrZXkgdHlwZXMgY291bGQgYmUgY3JlYXRlZC4NCj4+ICsNCj4+ICtVc2FnZSBFeGFt
cGxlcw0KPj4gKz09PT09PT09PT09PT09DQo+PiArDQo+PiArSG93IHRvIGNyZWF0ZSBhIHNpZ25p
bmcga2V5Og0KPj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICsNCj4+ICsuLiBj
b2RlLWJsb2NrOjogYmFzaA0KPj4gKw0KPj4gKyAgY2F0IDw8RU9GID4gY2xhdmlzLWxzbS5nZW5r
ZXkNCj4+ICsgIFsgcmVxIF0NCj4+ICsgIGRlZmF1bHRfYml0cyA9IDQwOTYNCj4+ICsgIGRpc3Rp
bmd1aXNoZWRfbmFtZSA9IHJlcV9kaXN0aW5ndWlzaGVkX25hbWUNCj4+ICsgIHByb21wdCA9IG5v
DQo+PiArICBzdHJpbmdfbWFzayA9IHV0Zjhvbmx5DQo+PiArICB4NTA5X2V4dGVuc2lvbnMgPSB2
M19jYQ0KPj4gKyAgWyByZXFfZGlzdGluZ3Vpc2hlZF9uYW1lIF0NCj4+ICsgIE8gPSBURVNUDQo+
PiArICBDTiA9IENsYXZpcyBMU00ga2V5DQo+PiArICBlbWFpbEFkZHJlc3MgPSB1c2VyQGV4YW1w
bGUuY29tDQo+PiArICBbIHYzX2NhIF0NCj4+ICsgIGJhc2ljQ29uc3RyYWludHM9Q0E6VFJVRQ0K
Pj4gKyAgc3ViamVjdEtleUlkZW50aWZpZXI9aGFzaA0KPj4gKyAgYXV0aG9yaXR5S2V5SWRlbnRp
Zmllcj1rZXlpZDphbHdheXMsaXNzdWVyDQo+PiArICBrZXlVc2FnZT1kaWdpdGFsU2lnbmF0dXJl
DQo+PiArICBFT0YNCj4+ICsNCj4+ICsgIG9wZW5zc2wgcmVxIC1uZXcgLXg1MDkgLXV0ZjggLXNo
YTI1NiAtZGF5cyAzNjUwIC1iYXRjaCBcDQo+PiArICAgICAgICAtY29uZmlnIGNsYXZpcy1sc20u
Z2Vua2V5IC1vdXRmb3JtIERFUiBcDQo+PiArICAgICAgICAtb3V0IGNsYXZpcy1sc20ueDUwOSAt
a2V5b3V0IGNsYXZpcy1sc20ucHJpdg0KPj4gKw0KPj4gK0hvdyB0byBnZXQgdGhlIFN1YmplY3Qg
S2V5IElkZW50aWZpZXINCj4+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+PiArDQo+PiArLi4gY29kZS1ibG9jazo6IGJhc2gNCj4+ICsNCj4+ICsgIG9wZW5zc2wgeDUw
OSAtaW4gLi9jbGF2aXMtbHNtLng1MDkgLWluZm9ybSBkZXIgXA0KPj4gKyAgICAgICAgLWV4dCBz
dWJqZWN0S2V5SWRlbnRpZmllciAgLW5vY2VydCBcDQo+PiArICAgICAgICB8IHRhaWwgLW4gKzIg
fCBjdXQgLWYyIC1kICc9J3wgdHIgLWQgJzonDQo+PiArICA0YTAwYWI5ZjM1YzlkYzNhZWQ3YzIy
NWQyMmJhZmNiZDkyODVlMWU4DQo+PiArDQo+PiArSG93IHRvIGVucm9sbCB0aGUgc2lnbmluZyBr
ZXkgaW50byB0aGUgTU9LDQo+PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+PiArDQo+PiArVGhlIGtleSBtdXN0IG5vdyBiZSBhZGRlZCB0byB0aGUgbWFjaGlu
ZSBvciBwbGF0Zm9ybSBrZXlyaW5ncy4gIFRoaXMNCj4+ICtpbmRpY2F0ZXMgdGhlIGtleSB3YXMg
YWRkZWQgYnkgdGhlIHN5c3RlbSBvd25lci4gVG8gYWRkIHRvIHRoZSBtYWNoaW5lDQo+PiAra2V5
cmluZyBvbiB4ODYgZG86DQo+IA0KPiBBcmUgb3RoZXIgYXJjaGl0ZWN0dXJlcyBkaWZmZXJlbnQ/
IHdoeT8NCg0KVGhpcyBleGFtcGxlIHdvdWxkIGFwcGx5IHRvIGFueSBhcmNoaXRlY3R1cmUgdGhh
dCBib290cyB0aHJvdWdoIGEgc2hpbSBhbmQgaGFzIA0KbW9rdXRpbC4gIEknbGwgZml4IHRoaXMg
YW5kIHJlbW92ZSB0aGUgcmVmZXJlbmNlIHRvIHg4Ni4gIEknbGwgYWxzbyBmaXggYWxsIHRoZSBv
dGhlciBjaGFuZ2VzIA0KeW91IGlkZW50aWZpZWQuICBUaGFua3MuDQoNCg==

