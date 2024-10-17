Return-Path: <linux-efi+bounces-2005-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FDD9A3001
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 23:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852711C21BF1
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 21:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DBB1D6191;
	Thu, 17 Oct 2024 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pb+bg9fp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n1y1r7d4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033A1386B4;
	Thu, 17 Oct 2024 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201674; cv=fail; b=KkvwwBduyHE1Cs3g8g4K2lMBBSX2th8ltEoszk6YUIlcPsSY2c8nOOgk3RYv3+F5DSEoZmL/4IrXpYSmLSkjOy+Io4mOsdpDzDcDLSpiln1u05HzTVWVmmACn9BlwWSNx1Lof45IfhsQDdZbjZW9X1iVjnF5yrRRbSzjbxL3cZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201674; c=relaxed/simple;
	bh=ezkcVftfws3O0T3VNC4GFrg1Cp7GXWGAJX3roC7B/1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rbObmpYaldvLjyAlgRAgPp2F9IVmGVt/j7SrUXyI0npGB7n3jMKpNDqhS1NZQntQ4uP9dXC07+R/9K0G5p60hMyyD41luRNL44ywC/nkSWKbco9wToEKbbwVvG3e/vIYgDuNn5bP56YWXe17Qtlh5EhBRcXtLa0Ef6pYpRRNO2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pb+bg9fp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n1y1r7d4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKtiXV001592;
	Thu, 17 Oct 2024 21:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ezkcVftfws3O0T3VNC4GFrg1Cp7GXWGAJX3roC7B/1g=; b=
	Pb+bg9fpVjMnTj47gxyIZvrWzV7uEFVIYAzndVKSQ1DjJQEDDWXGq4c8nbSkPXoP
	XbJtzgqIY75n6WtAWJHZEax3C4QSQn2erN2nl+R14doGlSo7UMAIArj+roMNrUs8
	29TanHXTNB1SsxKQdq04QSflfU+TWwHYd3rQaVFMRK7I9wpESz9kZg0FVQCBl3V4
	hdX9Ov2UIiu1Ni/n7c5jUT0fgQY2rmarpXu8gNPTvJfTUesWgDZT/ChilmP4PY9s
	Gk/v9vhyTcL8bp3+MALb9rlwaqGFhtc1VfPPIb4Lpc5iE2y4S6mr0OBtAmQ4s3pi
	nKfnWKO4Sz+vAuvRnTSpxQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt7fud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 21:42:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKEuUN027565;
	Thu, 17 Oct 2024 21:42:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjhe6fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 21:42:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJDZDBah3glc8OY2GaaMTxf1r0USFitlfNym0dfulYl6NevoWxs0gk8sbv6OuJLkBezWde3QVD+3PbxHwGRUmm1Eazuj5EFeU8wD+rr0vB5nv4aqV0HsKpWIWBVMXPPxzu8xL3MIvn27DIkiyYA+z597fNK+KXR9GqNyFf5ANur1qH+0sGO/6ioLa8+1EZoJcCOpj4eiWldTvLHHK+fDYx7faJG16hdtu5zWNIN4n4bAtaXqBOeCOwLIo/zrUY0krVr11ePYnJi80xDvgt+hLqRTYxTVj9WFEc6KPw5GJOoC7c6yCghEMYcu2HfnR9ZN9c40Zd0A9EItaN/Gep1Bjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezkcVftfws3O0T3VNC4GFrg1Cp7GXWGAJX3roC7B/1g=;
 b=IGGYTtIZjdaNj5E+c61WvJGW2gJRt+7+wq9tJ2z34pYY9NVL0+qyrPfM4bM38c1TlDaxctRY+fArN08VnRa2dMQFKl9EqqpSvd884csUPRZmDXpSfaBtpeCNqHZF3m+K5o6nYGZ/tImVFMvvqbqQx2799Q7msaheRekDMt4NndQy/myZSPx8o/EoHitnCP2gkqAIttp7yPoth5lrAi2n4BonjwI9Ncz8gBdcui7K5zX4AlNInHpL5IRSKox2aAXA9nebvZhab3XOMVoRCGCvVfY01aUPejbVf3p1I4XIGRI0BE6YGotrFNHgmkTQqWG33uN1ale/vczVMDK8B0y14A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezkcVftfws3O0T3VNC4GFrg1Cp7GXWGAJX3roC7B/1g=;
 b=n1y1r7d4upXMdVGjTlxN4SjO6kA0JOK/oS4v6xRUOOgjRZ9iv+V15qAlunTbxwc+lHFeIg3+4jlsfB3zwk/SRpqXU0+HDXzqdDjuih2rye15oCCYJNLcM+BrWRDQWspzXL7zrgrWVBDE8lu6eRYdQxXzHYTLfYluuoWfFYz9BnE=
Received: from LV3PR10MB7748.namprd10.prod.outlook.com (2603:10b6:408:1b4::11)
 by CYYPR10MB7608.namprd10.prod.outlook.com (2603:10b6:930:bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 17 Oct
 2024 21:42:19 +0000
Received: from LV3PR10MB7748.namprd10.prod.outlook.com
 ([fe80::1683:6bbd:7cd2:fff1]) by LV3PR10MB7748.namprd10.prod.outlook.com
 ([fe80::1683:6bbd:7cd2:fff1%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 21:42:19 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
CC: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel
	<ardb@kernel.org>, Paul Moore <paul@paul-moore.com>,
        James Morris
	<jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar
	<zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
	<mic@digikod.net>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        Stefan
 Berger <stefanb@linux.ibm.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>,
        "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH v3 04/13] keys: Add new verification type
 (VERIFYING_CLAVIS_SIGNATURE)
Thread-Topic: [RFC PATCH v3 04/13] keys: Add new verification type
 (VERIFYING_CLAVIS_SIGNATURE)
Thread-Index: AQHbIK0JFPRRNg0utke6tqHI/Bzp27KLUgWAgAAndQA=
Date: Thu, 17 Oct 2024 21:42:19 +0000
Message-ID: <46017A8E-88EB-4B8D-9FB2-643F9A5BF7F0@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-5-eric.snowberg@oracle.com>
 <24f4db65f9417b5a686b642bf5a8559236efafb9.camel@kernel.org>
In-Reply-To: <24f4db65f9417b5a686b642bf5a8559236efafb9.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR10MB7748:EE_|CYYPR10MB7608:EE_
x-ms-office365-filtering-correlation-id: f5feed64-4482-45ed-f472-08dceef4937b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2RMRXZUY1Nqa3JzclBHLzhHYzVJb3BjSXppYTZpWmszekFqSklqWStMTmt3?=
 =?utf-8?B?Ky8zU0J0bGF3dExSTjF4cUozeGlzMlkzbmtaTzQ3OStWakVCbEJ6SjVXNGRY?=
 =?utf-8?B?dXNlZnNxTHRjNHRkUXpjeEtCQlo1T0pmdlR0YW55VlhKZ2diV3JGRk9JK2pQ?=
 =?utf-8?B?L2NOQ3BBcENFdGJUSVBEQWllYmV4NmdiYXY5ZTMraTNDN1RSNi9tRktjSnNI?=
 =?utf-8?B?QmwxZ2JCTy9wVjhZTC9MSDBHWERHaXl0VlpDTWNKMWlCdHRna0huRVZ1Ym1J?=
 =?utf-8?B?K0NMWnJsOW9PT0pid2M5R3lvZFdUZWJXemRzV0VZalZZTENDU3IzVWxQSFUw?=
 =?utf-8?B?emN1dThpcjZoTDNiRTV5M2F0cFU2MDM0NFgwWlJQMmtndXhOelpqNGxQV1VQ?=
 =?utf-8?B?bnBxbnRIRVNTOXRReXNRL1QyTzVyd2RiV0hVRzgyUExMbUwzdlV4VWxiUU9K?=
 =?utf-8?B?TzZsa1pBdXYvWU1EcTArYU5YVlB1TjVhS3M5NklPc0k5L1dLSWM5RTlJN25S?=
 =?utf-8?B?ZjAwM2xRdEJVN3crL0gvelNUdXZqcHNpdWNVczVtbGZ4OWJocGRyR1p1bldp?=
 =?utf-8?B?Vnp0TTl6L0pSWnhwR1NqVGZ1dGdyVEYvZmxDSGdxZVoydG43OGhxbGJVZ1Bn?=
 =?utf-8?B?U1pMMG1VQ2Fnd3RFNVp2N1ZmaytUZ1VpU1YyUGl4NWRxZ3RweE1rZTYxNzVN?=
 =?utf-8?B?cjdSRTJMaHcyMWR2VUZPYmlPQU5xVDFoQXZTQmRlOGJqeFAreTArTnczZGMv?=
 =?utf-8?B?S1ZoaVc1YzAzYTh3bzZHTWVIVm9Bd2lNOTd1dEZrMVBSU0lUQUhlOTlEVHNH?=
 =?utf-8?B?ellUdEtieWlvOElkM2tpMkIvcnUwK2xoaEpRdFExZnpXR2hSYnRhV3dpd3NU?=
 =?utf-8?B?VzZ4dXE2WGt4d3pOWXdXNmpnNnZOeWRkbFlqZ213VE8reDdzZWsvMENXUzM4?=
 =?utf-8?B?N0oyRzZGNFpIUWhDazJ4NDNpMldtZzltbXlIb3owWnNILzUrL3V0WEwwOGlR?=
 =?utf-8?B?TWIrUk96YWdsWThhczJPb3NZWEVWRDBwbG1SMTU5Nm4vQ1NjNXgvbXNDNkR6?=
 =?utf-8?B?NWlwU0tJRXNBQlVuc01iZGhmNG84ZmtLRm5tblV2UXN0Z293K05WUCtKOEZo?=
 =?utf-8?B?VXRMR0Y4ZGp1SGplNnViNlIyZzdWNlpIMmwxcm5NZm9iNXZUTVZwdEF3RG1v?=
 =?utf-8?B?blhCVS9WeWxINVcwdThMUVdIYWViVUpUR1hZdm1EZ1FVaEREM2lXOG4yb3Vt?=
 =?utf-8?B?b2ZSV3FybDBSSlZobUpFMzB5KzMxM1djd1JyZzRWQ0VDS3p4aTl0VXdFdm40?=
 =?utf-8?B?YmszOHlPVWZXOFNYOFNMdTVaMGxRVExYMUprOGxWTzlKTEpsNDFVeXNpSUMz?=
 =?utf-8?B?NU5OdWMydE5OOHk4ZnlJZGFIdmJkbGphSTJ3RG45aW9UL2NzT1Fzbml1TDRY?=
 =?utf-8?B?NmxQTGJZalVnRVhBNlJJbFZxdHptN1RPUENYTysxa0NmelIyMTlWWTU5cVJL?=
 =?utf-8?B?UldLVElpZUF5eTUwbjlyVUZSSDZ0S1dWSEZXUitEUkZzZkpra2tzZU1XMzVC?=
 =?utf-8?B?M1RVTHZLZU9VTW1pR1ovSjR6ZzZTNTBZR2JIQUZ3QjFJUGplQ2p5anh0RXQv?=
 =?utf-8?B?Y05ZMVUvcUpibWo0RXVjeFU5RDNNbVlXZWtmeHB6eUUwSURkZ1N1NFE0UG1m?=
 =?utf-8?B?ZnRBVkxxNGNRc3dnVkdYTjR4Z21LMUVuWTlZYVg0Um5RT1RmQkxjcUtaQXpI?=
 =?utf-8?B?bzMrTEJVbE9yS09iTng3OGFUS3ZNajVIVjVFbWZjWG45WmxoRTZqZXRXVExm?=
 =?utf-8?Q?3Ea8xmkZxjc3M7+9qtL3TduiBzl9q6Too8DbM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7748.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTVoVHp1VkFiNlFxMkZldG5tV1htT1EwdnlkRXNaRlBSeGcwMGozNEZWdk5Z?=
 =?utf-8?B?S3B2WDkvcTFyUGhvbHlmNUxFL2tROHgwejBVVWtxcXlwZHVwbG9CSTJvSENR?=
 =?utf-8?B?OXZiaStEZ1liaG9kQlhsRTY5alhCMGtteG5vbXpPOTNZeEQzN3I3RGpoRkdF?=
 =?utf-8?B?Sy9wdWZUZ0FKVDJKVm9kZ0k4WnRhK285VnA3NXlMRFYwT1RGRFRNajlxd05W?=
 =?utf-8?B?bi9CZDZoa01wOHEyVnRLRnNxVFc0d1VNUG4xK2VPQjAxR0puQktaR3RKYlNP?=
 =?utf-8?B?RlJzWUFNMjVVYzdVb0tmR2ZiUCt3VXNzQ3JXVnNQN3pRMU9yQkN3clFTOFY0?=
 =?utf-8?B?NmJmNEJPVHlQa1EzVE1PTVloSmtUc25Gdk5Waks2ek9Za1o4ZTVWbWNGU3VB?=
 =?utf-8?B?MGpDUmdYS21STXRrbkNLRmkrUmxGSnVhN1F6amxzcktyRVVkTzBvVG9VRkZa?=
 =?utf-8?B?dWVRVGNEakxXTGVtMG1jK3d5WWZud1VueGhrbHVJK2piUVhCRWVhQjNYNDMr?=
 =?utf-8?B?bW1LY1cyTUpwL0pGMWpWR1kwYlBNdnFJTmtQYkM3bGFPVnp6aGdrVldMTExy?=
 =?utf-8?B?ZTNnQXpYSHRneGgxV3NUNXRkUGV3ZEZCZ0gxMDdENDYxSWhUVHFVMnBDeXFa?=
 =?utf-8?B?RW02UHZlSm9TWVhUMmIrdDgySTVpTGduUUhrNTY4Vms4SU1aNDQ3UXBXUDF3?=
 =?utf-8?B?c05oa0lBdjY0NmRXUk1RM01ySkpFcTNLS2k2cVcxWmJ0QnRYVzJzWGk5cFNy?=
 =?utf-8?B?aWg3TFBDSjFiWjdHYlJUSktGeDV3dTk0QUYvOFZHalJEWXR5N2hCVFlSdDNP?=
 =?utf-8?B?VDJoVzRSUEZjZlM3RVZUSHRDY0JaWUNNTkFFUTYrWHJ4RDk4YkRJamgxSzdP?=
 =?utf-8?B?MUI1L2Qvb0t5UHh4NXRISTgvUnVQL3g4WHk5MkxubnBnS1AwZDVyUTgyK1ZC?=
 =?utf-8?B?RUEwSDUrcm9jQkY2WS9DVUZmKzVSWHdtRmhzZ0g4bndTTkgybDlzVUtBcGt0?=
 =?utf-8?B?dWxyOHJlWjNucW50LzJqQUdLY1VPT21sb1pMVW1UNEZyTlpFODF1RVBGMlMy?=
 =?utf-8?B?OGRmWjRJN1ZENVRKZ3FGYWFzclVzdVlVZTJUdTcydFowRmdFN0V3VkplcnNn?=
 =?utf-8?B?YlYvODA3U2RoUVdFcnIwQTN1WndtQmU4QlpqOXpycm55WkNNRjNsUng1djZM?=
 =?utf-8?B?ZEN0VVAyM2Z3RFNGL3FkWTJJTm9PM2xDTjZPUUc0ZHB6RDRQQnR3REVUTTFZ?=
 =?utf-8?B?a3FIQjQrSnJlRVNZOGw0ZTlOYzMzUjIrZDFoQzRneVVwVlVUbm5tN2tZOEtL?=
 =?utf-8?B?ajZqaUlhS0lvYkNLNnBHbmhJSXlxMEFBWStxcllBWTB5dVZaWGFVYWlBR0Np?=
 =?utf-8?B?UWVMcjhGbzdoNnAxT0ZZdHBFdXBsOHZObmxWRTEzRTNOQ1ZMSFF5SmtiNjZU?=
 =?utf-8?B?cVg3cXhKOWkzZjVsSitueEJ5Mkhqa09SZThYZ2ZMdU5Wbk5VS2NjRzFjcXNJ?=
 =?utf-8?B?eFBiWmxlVnluVkJlUlVBdDJjbHp6QnFIM1ZSK3Rid1lsZ1NiSmpINDVJbWZt?=
 =?utf-8?B?bFVmYXJISUNYYWdIRFFmbHZaWDdjakFDZndoMmkweEk5cDBWZ0l0ZFBQeGhP?=
 =?utf-8?B?SmJIWXlKZWtJeDNLRkhaWjRNWnhleWo5eG9LcHNHSG82VDJaWXlJcWxSMktC?=
 =?utf-8?B?QS9sQlBzdnlWMnVGL09pWk5LWHFweXA0cEdPT014MVFldWZ2WWlZeVByeXQ3?=
 =?utf-8?B?UkJSeElXb1VzU0Vpd2UyNDhxQlZqUmo4eUpFcWgxTVluVGsvVDRxVTZ3a1Ur?=
 =?utf-8?B?U1JVcmREZUkva2ppRWhrOG1IUGxoSUhITU5Bank2Rm9BeDYrKzZnRTNTa0Ra?=
 =?utf-8?B?NlJ0R2krSmdFL3RRZlYwRDFJZVZyMVdLVFVCYmQ2WEtkdTlKU2gyL3VKZ0hT?=
 =?utf-8?B?MGE2TEFRMUE3SzZmeC9qZzk3QjhhcEpiWGFFQ1lITWVTV29BWll4VGdlM05V?=
 =?utf-8?B?VjNFNHlUR0VsSkFRMVVhOXRndkdTSXJMOGZCNjBYR1dFTU55c05aN1l5ekg3?=
 =?utf-8?B?RVNrN1VpcDdrTEJJQ0pKWDFKQzZWWDIwaUwrVnY3L1pLVmU1U3NnL25qVXEy?=
 =?utf-8?B?ekFmYm05b3VDVzNYeThjTzN1dHUrZDFIeVFoTEFnN1Z0a29Rdmw1ei9KdTBy?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <986E508C90DE1F4FA440C88C2257B2E0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vR5OL+siuHUVmDa56k7yKjU4HB+hSJZLvGuxf7KyWUKZ0h/BPy6/E9AeoDg+o44qmqpJm3SFa78J7rU7E+x3H6KUPvLrVdO0dTY1ImkLR6/ZIwFr/i81CkX4XWtUevwsf4wWNH5eD/QynT2phlQsgwbzNyG5kqGglCWYzNIOx3+WYrLEDAxDl2dsY7aS4700aMAStDZWWst2f5dWasP7SXvGkRNMre0FIsvFBeE+G1yXM6ypkYd+Dk7np8ThwdbUwwDgxHtYbgjzTF2YhzNJ7LB8y+CNY0vN7qT7viN5v2ZTtzNpuk8ddN1BjO/mOHi5te/kAFe+VvR0dvE2JVa0m71J05CAcNcbHDxeoepB2J66GeTvGfQaveYl4gQo6b+tcMmC0AvOj2M+uo0IjSlcG5DFpr9keKAt2Mb1wQbp/mbDgpHL8uzfz9kGcj4Qafp0PT+L2vp5OIkMLcQIge57hXN84vn8WP4h771JYGRgaBojuigz/m+bdQ3o2JbwgAWL8OCpd+20OGphdG2ypEQpZHPAPGitzYOLH1MeJ89Bowm6gHrhh01GvAJoG2OW7TGvwQKUCC7M714ckdin9USuXvMv6C7l0WPh6z+Vb1IwlfI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7748.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5feed64-4482-45ed-f472-08dceef4937b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 21:42:19.3165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cRRQlM1MD9Rdy4Hcj0NRR7/Zb5qqmO1kN2KGg85oGTK2QyeTJ9AnvPOO7lUPmMNsG0M+KX+LJy2bzIuDRcUBQqSzx8v+cb9IOFdfR7PVBms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_24,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170146
X-Proofpoint-GUID: 42B1K3fl5KEzAVb6_N4TlZEXaospD6jJ
X-Proofpoint-ORIG-GUID: 42B1K3fl5KEzAVb6_N4TlZEXaospD6jJ

DQoNCj4gT24gT2N0IDE3LCAyMDI0LCBhdCAxOjIw4oCvUE0sIEphcmtrbyBTYWtraW5lbiA8amFy
a2tvQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDI0LTEwLTE3IGF0IDA5OjU1
IC0wNjAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4gQWRkIGEgbmV3IHZlcmlmaWNhdGlvbiB0
eXBlIGNhbGxlZCBWRVJJRllJTkdfQ0xBVklTX1NJR05BVFVSRS4gIFRoaXMNCj4+IG5ldw0KPj4g
dXNhZ2Ugd2lsbCBiZSB1c2VkIGZvciB2YWxpZGF0aW5nIGtleXMgYWRkZWQgdG8gdGhlIG5ldyBj
bGF2aXMgTFNNDQo+PiBrZXlyaW5nLg0KPj4gVGhpcyB3aWxsIGJlIGludHJvZHVjZWQgaW4gYSBm
b2xsb3ctb24gcGF0Y2guDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgU25vd2JlcmcgPGVy
aWMuc25vd2JlcmdAb3JhY2xlLmNvbT4NCj4+IC0tLQ0KPj4gIGNyeXB0by9hc3ltbWV0cmljX2tl
eXMvYXN5bW1ldHJpY190eXBlLmMgfCAxICsNCj4+ICBjcnlwdG8vYXN5bW1ldHJpY19rZXlzL3Br
Y3M3X3ZlcmlmeS5jICAgIHwgMSArDQo+PiAgaW5jbHVkZS9saW51eC92ZXJpZmljYXRpb24uaCAg
ICAgICAgICAgICB8IDIgKysNCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0K
Pj4gDQo+PiBkaWZmIC0tZ2l0IGEvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9hc3ltbWV0cmljX3R5
cGUuYw0KPj4gYi9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL2FzeW1tZXRyaWNfdHlwZS5jDQo+PiBp
bmRleCA0M2FmNWZhNTEwYzAuLmQ3YmY5NWM3N2Y0YSAxMDA2NDQNCj4+IC0tLSBhL2NyeXB0by9h
c3ltbWV0cmljX2tleXMvYXN5bW1ldHJpY190eXBlLmMNCj4+ICsrKyBiL2NyeXB0by9hc3ltbWV0
cmljX2tleXMvYXN5bW1ldHJpY190eXBlLmMNCj4+IEBAIC0yNSw2ICsyNSw3IEBAIGNvbnN0IGNo
YXIgKmNvbnN0DQo+PiBrZXlfYmVpbmdfdXNlZF9mb3JbTlJfX0tFWV9CRUlOR19VU0VEX0ZPUl0g
PSB7DQo+PiAgIFtWRVJJRllJTkdfS0VZX1NJR05BVFVSRV0gPSAia2V5IHNpZyIsDQo+PiAgIFtW
RVJJRllJTkdfS0VZX1NFTEZfU0lHTkFUVVJFXSA9ICJrZXkgc2VsZiBzaWciLA0KPj4gICBbVkVS
SUZZSU5HX1VOU1BFQ0lGSUVEX1NJR05BVFVSRV0gPSAidW5zcGVjIHNpZyIsDQo+PiArIFtWRVJJ
RllJTkdfQ0xBVklTX1NJR05BVFVSRV0gPSAiY2xhdmlzIHNpZyIsDQo+PiAgfTsNCj4+ICBFWFBP
UlRfU1lNQk9MX0dQTChrZXlfYmVpbmdfdXNlZF9mb3IpOw0KPj4gIA0KPj4gZGlmZiAtLWdpdCBh
L2NyeXB0by9hc3ltbWV0cmljX2tleXMvcGtjczdfdmVyaWZ5LmMNCj4+IGIvY3J5cHRvL2FzeW1t
ZXRyaWNfa2V5cy9wa2NzN192ZXJpZnkuYw0KPj4gaW5kZXggZjBkNGZmM2MyMGE4Li4xZGM4MGU2
OGNlOTYgMTAwNjQ0DQo+PiAtLS0gYS9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL3BrY3M3X3Zlcmlm
eS5jDQo+PiArKysgYi9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL3BrY3M3X3ZlcmlmeS5jDQo+PiBA
QCAtNDI4LDYgKzQyOCw3IEBAIGludCBwa2NzN192ZXJpZnkoc3RydWN0IHBrY3M3X21lc3NhZ2Ug
KnBrY3M3LA0KPj4gICB9DQo+PiAgIC8qIEF1dGhhdHRyIHByZXNlbmNlIGNoZWNrZWQgaW4gcGFy
c2VyICovDQo+PiAgIGJyZWFrOw0KPj4gKyBjYXNlIFZFUklGWUlOR19DTEFWSVNfU0lHTkFUVVJF
Og0KPj4gICBjYXNlIFZFUklGWUlOR19VTlNQRUNJRklFRF9TSUdOQVRVUkU6DQo+PiAgIGlmIChw
a2NzNy0+ZGF0YV90eXBlICE9IE9JRF9kYXRhKSB7DQo+PiAgIHByX3dhcm4oIkludmFsaWQgdW5z
cGVjaWZpZWQgc2lnIChub3QgcGtjczctDQo+PiBkYXRhKVxuIik7DQo+PiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC92ZXJpZmljYXRpb24uaA0KPj4gYi9pbmNsdWRlL2xpbnV4L3ZlcmlmaWNh
dGlvbi5oDQo+PiBpbmRleCBjYjJkNDdmMjgwOTEuLjAyZDJkNzBlMjMyNCAxMDA2NDQNCj4+IC0t
LSBhL2luY2x1ZGUvbGludXgvdmVyaWZpY2F0aW9uLmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgv
dmVyaWZpY2F0aW9uLmgNCj4+IEBAIC0zNiw2ICszNiw4IEBAIGVudW0ga2V5X2JlaW5nX3VzZWRf
Zm9yIHsNCj4+ICAgVkVSSUZZSU5HX0tFWV9TSUdOQVRVUkUsDQo+PiAgIFZFUklGWUlOR19LRVlf
U0VMRl9TSUdOQVRVUkUsDQo+PiAgIFZFUklGWUlOR19VTlNQRUNJRklFRF9TSUdOQVRVUkUsDQo+
PiArIC8qIEFkZCBuZXcgZW50cmllcyBhYm92ZSwga2VlcCBWRVJJRllJTkdfQ0xBVklTX1NJR05B
VFVSRSBhdA0KPj4gdGhlIGVuZC4gKi8NCj4+ICsgVkVSSUZZSU5HX0NMQVZJU19TSUdOQVRVUkUs
DQo+PiAgIE5SX19LRVlfQkVJTkdfVVNFRF9GT1INCj4+ICB9Ow0KPj4gIGV4dGVybiBjb25zdCBj
aGFyICpjb25zdCBrZXlfYmVpbmdfdXNlZF9mb3JbTlJfX0tFWV9CRUlOR19VU0VEX0ZPUl07DQo+
IA0KPiBUaGlzIGxvb2tzIGFzIGdvb2QgYXMgaXQgY2FuIGdldC4gSnVzdCB3b25kZXJpbmcgdGhh
dCBkb2VzIHRoaXMgQ2xhdmlzDQo+IHRoaW5nIGNvbm5lY3Qgd2l0aCB0aGUgVFBNMiBhc3ltbWV0
cmljIGtleXMgdGhhdCBJJ3ZlIGJlZW4gd29ya2luZyBvbj8NCj4gSS5lLiBjYW4gdGhleSBiZSB1
c2VkIGluIHRhbmRlbS4gSSBzaG91bGQgcmVhbGx5IHVwZGF0ZSB0aGF0IHBhdGNoIHNldA0KPiAo
bGF0ZXN0IGZyb20gQXByaWwpLg0KDQpXaXRoIHNvbWUgY2hhbmdlcywgSSB0aGluayB0aGV5IGNv
dWxkIGJlIHVzZWQgaW4gdGFuZGVtLiAgSWYgSSdtIGxvb2tpbmcgYXQgDQp0aGUgY29ycmVjdCBz
ZXJpZXMsIHRwbTJfa2V5X3JzYV9kZXNjcmliZSB3b3VsZCBuZWVkIHRvIGJlIGNoYW5nZWQgdG8g
DQpyZXR1cm4gYSB1bmlxdWUgaWRlbnRpZmllciwgaW5zdGVhZCBvZiAiVFBNMi9SU0EiLiAgVGhp
cyBpZGVudGlmaWVyIGNvdWxkIGJlIA0KdXNlZCBpbnN0ZWFkIG9mIHRoZSBza2lkIHdoZW4gY3Jl
YXRpbmcgYSBDbGF2aXMgQUNMLiAgVGhlcmUgd291bGQgcHJvYmFibHkgDQphbHNvIG5lZWQgdG8g
YmUgYSBuZXcgc3lzdGVtIGtlcm5lbCBrZXlyaW5nIGNvbnRhaW5pbmcgdGhlc2UgVFBNIGtleXMu
IA0KU2ltaWxhciB0byB0aGUgYnVpbHRpbiwgc2Vjb25kYXJ5LCBtYWNoaW5lLCBldGMuDQoNCg==

