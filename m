Return-Path: <linux-efi+bounces-2010-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E549A494A
	for <lists+linux-efi@lfdr.de>; Fri, 18 Oct 2024 23:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C361F22B5D
	for <lists+linux-efi@lfdr.de>; Fri, 18 Oct 2024 21:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6C718FC65;
	Fri, 18 Oct 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gbWH7keD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="inWYRyPR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A8618C34B;
	Fri, 18 Oct 2024 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729288587; cv=fail; b=HnYKK4PJPdbKLoW1KhiOYwJxVqw6LVhoXgCGtOHIQYv6uXFBsW29IiPj4A62ClEatbmzU0SYIHkpm4GyuftPgfuWIKy54YYQflz79qnB36X3wxAd6+K54kAYnmYQfEHuW0jEUJDRGA6wCxl+Q/rJDviUWMCMDx+FXYIY/n+N4yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729288587; c=relaxed/simple;
	bh=+uhaQhEPa5rNA19HNphn8wJzbMdNjkS6bPAC0NCkYlE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I5CsabGLMwTeTiyj2zt9uEzwBI7BfBKEs1uBLI6GmgxKNukmkqnzDGBqZD3Q1i49A5ZcaYvnTAPF8Hc2W9YZYXkTscz9Yji3a9Y50eJYjfeY5AzPFbaC2f2EElrWxW/8cx7J3xaSIL5mQaWxYR7zk96eH8eFUIhYkgFkfapcJIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gbWH7keD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=inWYRyPR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IKBfw3031108;
	Fri, 18 Oct 2024 21:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+uhaQhEPa5rNA19HNphn8wJzbMdNjkS6bPAC0NCkYlE=; b=
	gbWH7keDSmBs1saWyd2418imvPYQv0WvvK48Al30LuMQXMwta63AbIsgO7s/Tpbr
	i34sPzyaybOYhWXvUs3yxOtQkLvMkicLTo7iPiTGDwgmma4y0ch4c11fNU6du09D
	1NvZhlevzai8ORsSI6w4Cf5quPkQ0XIWn/MpDI0I5qqUKVGD4ljqCvMEoRueLzzI
	t1IRH5IFnNBHcZjpLBdxTNDtKFigSYP434IsK5ik3s4aUoy42rJlm/E7mIplYHdA
	BsgL1s3X0SHPMyo/LqMkeuAJ7XfHa6b9fKniVTRdjthx7lPoye2SfgA59pWdVang
	mEHS01exBJhYfum2bP4jYg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09s6uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:55:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IKRJYQ019423;
	Fri, 18 Oct 2024 21:55:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjc473v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:55:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnQsy7mjInPpIXP2v/dKaKZSR7s+HHvsOnsNruxi8KMouKDfrpqR7KcfMoIm8Fz9UtT1el0u9Dq7V9QENfpfn4kkrWg/KAGYwHoyGak3kalabR34bEzX0I0KASGG6PDTgQdTzpgMrltzYmd5aYQmuh1iuFkglUYfFuoSycHQUGh5GLOZUJYTTwtwuruym8aq7zW1+MFGYWRWbLIeDgDX2IN4PZsRSB94g5kVrRSl6RKVzkbvquZJKeDrVfBMryN73s2Qt/WvXJwUAWrZnB7XB8W7iKN83fgXpoOtcYV52XBOE00ZKFpeCi429LqyWrukBQyU9cXsdguLV3zP4EXuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uhaQhEPa5rNA19HNphn8wJzbMdNjkS6bPAC0NCkYlE=;
 b=KcUITza3Y/fZJuYbtLQnGvJrshT+5Nz7zV3M6W14b5dTg3lD+3oD3e6AgpnEReS+AQiWbVh3rjtCdaStWq12oUxEMDfGX2hgnFh/Dol5LQdswHVSWt4dqveZKnDDuQsUzV6Gb+bbjOLI9bwVqa3o+G/u6Qedt1t0gx7QZYsb0YTdrJnIEcujmST+0IwVcEVkX9YdIa1d5uulJbbEn7mM9vUZkm/RtGNUcTXT18vj7d6gBBTblQQw6SwZt8hb42yGhQbA0gebxeowWiN73C6z6iNf498EPzBzhz2mN3a1w0uzvxO8uUESr3YJ0VAtbolGEaD94/5QcnHsj6rTVKD6tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uhaQhEPa5rNA19HNphn8wJzbMdNjkS6bPAC0NCkYlE=;
 b=inWYRyPRwxwog9+VxUee76GOmt1N9iK25NlJa6H0/B9OE0xu1pzsuogXJ1rCIyspLMlZ8eETnoIISCppLyQ104Ek2V7bSE1gBdumFuKp4aT5Xu/a3TF7ALn0GCaNnDAOb4EcVvkUvEF8YQltgI5OqNLHmudXISMBZTcb0zRHL2M=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by SA3PR10MB6949.namprd10.prod.outlook.com (2603:10b6:806:319::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 21:55:41 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Fri, 18 Oct 2024
 21:55:41 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Ben Boeckel <me@benboeckel.net>
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
        Randy
 Dunlap <rdunlap@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH v3 05/13] clavis: Introduce a new key type called
 clavis_key_acl
Thread-Topic: [RFC PATCH v3 05/13] clavis: Introduce a new key type called
 clavis_key_acl
Thread-Index: AQHbIK0LtFdZeAa2vEyhuI80sKG05rKL+eMAgACtU4CAABRjgIAAU/IA
Date: Fri, 18 Oct 2024 21:55:41 +0000
Message-ID: <3018D440-A632-4F5E-BF49-F2971FC4D5E4@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-6-eric.snowberg@oracle.com>
 <ZxHwaGeDCBSp3Dzx@farprobe> <2F718293-72DA-4E7F-99FF-690276B94F34@oracle.com>
 <ZxKS57wBfgBZ21_g@farprobe>
In-Reply-To: <ZxKS57wBfgBZ21_g@farprobe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|SA3PR10MB6949:EE_
x-ms-office365-filtering-correlation-id: 19e0caf2-f062-4d3a-2852-08dcefbf9bf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZzRnTllGMWY3ZzJVMjNXSkEwOWIzQkYxWGFLeVJKemJ6aVNmTGgzSjQyc1Vl?=
 =?utf-8?B?dFFETmI1aEdBczBDUjFlZXorZ2hGbnIyUnpiY1d0MTZlUUJnci9pcEtMTS9J?=
 =?utf-8?B?aHVQY3k4RTVLQnJFcVJiTDhkTXRKNXdJZ2lWOGhoTnREVUVJcXkvN1NPTWVZ?=
 =?utf-8?B?bmpzakNpTEVYWCtoREdzWG8xTy9SQU50ZUZiOHlwUXhiVDBUR2tOcS9HVUNq?=
 =?utf-8?B?bDEwNFNNbGhFWTdMbWlQaUxiMG5lOXNjTXg3WGFWUXQ5WHprZk5CVGJGYjlY?=
 =?utf-8?B?bUNiNEtLdUUwRFpqTEtlcEZwWFBPdldnSU5qOXlVdkNEZG9MVWt5ZmlQb1RB?=
 =?utf-8?B?RkNvMmdyNzljZkhOQXlHZnQwdHUzNWlpU2RTT3NlV0JoUVIraVFIN3ZUQXll?=
 =?utf-8?B?eEFndHR2ZUVVbTNYV3ppdXVBZzVwaElabXZINXo5bUI2c1R6NUJHOHVDTXZh?=
 =?utf-8?B?RDdwSXhrTkdyeHNIL1VJb2lqTmV4RWZVTUM4dm0zVnNEVmJVaFhzeTgybm5t?=
 =?utf-8?B?Vm9ZbmwyVW4zYlRLdGFZRnZBcFFrT0hDZXNDdlljVUgrSWhpNXhFUDJCcmxv?=
 =?utf-8?B?TDNkSGlVYUhadzJTMVNJMXJ4R05BNllOQUhmeUlKRjlLM2tkMkhQUDVmNUp2?=
 =?utf-8?B?NVR0QTd1c3o3TGtPbnhGdDN1NVdzQkdPaHQ3SjBPNEVpNkFsN1NFWVZyKzJl?=
 =?utf-8?B?YnlUTE5MTWx5TC9acGIxZUl1ekl4WUhzYTdkTGdpSnB1dWRTT1ZlK2hMa2Fl?=
 =?utf-8?B?NU9ObDI1RU8xSy80cHdmcDNzRXZkRFB4Z2VFZlJWWTA2TVNLUlQxWUc5VGgx?=
 =?utf-8?B?QmdicVZacVFzUmtPaHQ2WmF2aWF1bnZkV0xXTyt2WUpYT2RiR3lvL3BPLy9H?=
 =?utf-8?B?Q2UxZDBsclRmdDZ1WnYzbEFFWWFmZHA4MmVjRmVXa3BTZHF5TlpkOE9pd1JN?=
 =?utf-8?B?dk1YUjU2Mm11N2pYMXJnZU9aOUVYNmZWNGF6cVZwMGdtWVBNNEd4RlgvNnZv?=
 =?utf-8?B?a2NLUzVCSUZ5U215a2wxWGp4ZC9sb0ZEQ0xvNHZjWnZrbGxycURTNk5NcjhI?=
 =?utf-8?B?UTRDcDdXWVF1MFFyeGdvYUhoUDlGcGRSb2Fxd0VhSzVtckk0Vlp4aStvU3pH?=
 =?utf-8?B?eTRjbkhzUjZTUlFaVlJwa0ovQi9kRWIxaGJSNFZVaHJqYXJSS1lrdXhCdktt?=
 =?utf-8?B?WmMzVEg2ZmczbUQ4V3kyZklVcURxWEpTQzFmQlRVMDI5SjJmdHdqY3JhVzlD?=
 =?utf-8?B?eG1YV3hRUnpYcGU4a1ZPRXZwZmVwRFRXVjFTMzFzMGo4R2dlM0FPUE1WOHBk?=
 =?utf-8?B?TnZhNUo1TkNwZWkzZVpEbERJNmEvbFFvQ2RSTEZjQStxd1U2L0RKREx1UC9Z?=
 =?utf-8?B?SzJTS29pWTZGNURZNTkzR0hBRFNxeWFhTlV4ZWpGU0lSS2VxVXV3UU8xOXFM?=
 =?utf-8?B?ZnNrbDFaQVZ4c0IyVWIzekNpM3NBV09vZE5oZ1VaaGJCbHJZWUtrY2wvdE5L?=
 =?utf-8?B?UU12TG5RQWFsdm1aSnpFZUFGM1BHUXYvYjFNYnFRQXJlVFR6QWJZREQyM2ta?=
 =?utf-8?B?WEZyRXhqR2xSU2JCbjhIekJXWmlqcy8waUdjTEpzWU1ORk13THhYeEZFREdR?=
 =?utf-8?B?T3F3UmpMZU9yaUM3M1JLRjk5M2tYTEN6SU9SaFAxUjk5TUVXd0ZrdEdKRTlZ?=
 =?utf-8?B?RklCZHRaZGJRNU1odUh1VnRjeUd6QzE4ZVFHUUJIcEpiSXRCUndxbS9TQnRn?=
 =?utf-8?B?WitrSUFWR2ZRZGxDa2NrZ0oxMHJiM2tvMStmcEtDSXBMWElyZVJJd1dpT0ta?=
 =?utf-8?Q?sb7BpAi4/58FXUeJmnQIWufClGKuM6ICJWV1Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGQ1dG5jaGxzZWp6amFGV2FiMDR1NitlNnNqQ25lMktaOE9SM29kcnd0ckwx?=
 =?utf-8?B?VGR6K0NTRDdrSmp2Nk1CUDVpc3JPbUhMOUg3MlpJRHcyMjRmMmZoNHpJVlNo?=
 =?utf-8?B?bFFnYS95RjUyK3VJTlo3U1BFQjUwc1lUU0JueWRTcUlUellCdm5RMjg5RjBh?=
 =?utf-8?B?UlhvYmt5d2treVU3SWtNK2syb0pDQUhxZFdsTjlyUW83UXZka2NKa1ZVL2ZH?=
 =?utf-8?B?c0Z3Q1d5MFMveHdwekkxUkdDRWtZN3BvcURHUldTU0ZrR0hlZkNPVEFrb1pp?=
 =?utf-8?B?cVZNOGsvbE0yWEoxSE9wMnVuVzI3UUlGS2ZJWGlsbEtkSFlUT3Z2ajVYaXVm?=
 =?utf-8?B?dEF0MStTc2FEcHRncWQzSGJTcXpvL01OQ1dkcTdtUzZSOG1sZFhVRGtKYnI2?=
 =?utf-8?B?N040czlXRU5PNlJqdHMvUXQrWHZ4ODY0c0xRR2ZIYVdZbVhvWlJwaG9XNW1U?=
 =?utf-8?B?Q0d1em94emZKMi9LYWhqMlVySDNqQmVjK1Q4Y054ZGcyRGUxWjNSSXN5UUFZ?=
 =?utf-8?B?eWZpZnZkRmNRV2RpYzhYa0Y1Z0JDNDRNblZEU1ppV2tFNGRsQW5CU1l5WEJr?=
 =?utf-8?B?MUtBTUNGeUdqc3BDSTVRcWlmdFFvMi8xMjNsSE5ZbXlTT0IycU1wTHpPQWJI?=
 =?utf-8?B?RDJtSWpGQmF1M0ZrYk5KcjdCUUgwdDkydDdJblJiU213QUNDTkNoRHdFREJG?=
 =?utf-8?B?a3BIQzExaG1UR1A4Vm9BUlRyTm4zdjB2eWVRdXlaUlkyYThVclFtaUI0dDJK?=
 =?utf-8?B?WE45TWpHckdvdVc3L1d1SkZySGdMK0ZYY2lXKzVFV3l5aC84eStmby82MlFL?=
 =?utf-8?B?cWlHWnQrenZzZ1BLOXVDM1d6YUVvRHNvQUJYRm52YktLbWttWXRnQ3JRakdU?=
 =?utf-8?B?MTBTSGEvZVA3SWZYcnFnUWVzR3R0MXFnQW1JYUZvek4wTnRKaWN4RStUbTJp?=
 =?utf-8?B?S21OK2FXWWJTaGJQbzd6eGZQdkFZYUszUU9vUXpsV1N0TEk4RXViRWV0OXhP?=
 =?utf-8?B?OU5TaWhXejBHVzlxUC9PWDZrRHk1ZDNlMWpyRUk0S1ZqeEFiM0V4OW5rOStn?=
 =?utf-8?B?RkdYNy85TDJkYmpDNEVBZ0VZZWJlbDd0MklQK2IxY0dSajVvWDB3SEhka21B?=
 =?utf-8?B?bGZ6Ylh6UFMwWmMyRDA1TUM5eFRuZkpoQStpc2J1SXR3cnhxZHM5NllHTnNJ?=
 =?utf-8?B?UDQ5cnpQZE9HNElVZXV2Y05YQ05yZFNIRldDRnVuQVJTYi9SUVJYS3F3VHBT?=
 =?utf-8?B?YVJMQTNsOEg3alVXd2krb1puczhYMzlNTDBPZzUyeGtuOUI3azM4WFl0VzhC?=
 =?utf-8?B?VVF2ajBvRWpKS3VIenV2VklIQ0F1RVpMUnoxZWNHZlltOEh4MlFKdWtqZXZN?=
 =?utf-8?B?aHdha1pTejVqQ0VBUkp3aWFabW1XTmFZOGhrSHJnWXVkT0g5ODJJTi82dWxE?=
 =?utf-8?B?WVR1d3hiSzhNMWZxbFVyUjFIVTdndW5xQUNkOWhKbWF4T3pvQUYzRUw4dVVw?=
 =?utf-8?B?VHNjd0lNRkZmRWtaNytSTlh1aVppcHFPUkExMmJNNzhRaExIckU4WVRDd1Rl?=
 =?utf-8?B?ZGFpc1RIb0srbVh3d0FHUEttQVhHL1Y1ZzRsMjJXL2JiU1BTQ2RHSnEyVVYx?=
 =?utf-8?B?ZlBUa0x3VlBFREwvYXdEUm9KTEYvWnVqN2U2U09oNE9VM2lLeVBPc1ZpNkh4?=
 =?utf-8?B?dE8xTGtXVk5UeGl1elNvR1VrZEtwRExMTkt1cmV5bDVzS0I1WTIxbGdKNnlO?=
 =?utf-8?B?ZUNlUE04SEdIZWoyYkg5M01BK3RURzB5SDF4SmtiblE2YWR1akt4dzJRZlJC?=
 =?utf-8?B?Z2tFZERJeEVSS2x2bzEvUHdWOFVoMi9jMzNaeUZZS0hXZDRMZlhhT3lUN25F?=
 =?utf-8?B?Y1REbHBmc2xVY3JSVlJOVDBkM1ErOS8xZGdZZURTcFZTK0NkdkIyYzhCTUpN?=
 =?utf-8?B?V3ZIL0pQYTFzZFRRdXY0SGk0MHdwdFcrLzZSNjRnanhqMVBTOEpOdkp4L0du?=
 =?utf-8?B?eWdOUnJzVFNJN1JTWnNWM245dnNrUEZXQk1EL0d2K1E0R1NIajZhK3pBbkJo?=
 =?utf-8?B?UUNGRGY2WjJ4K1ZvMkM2Z292dzVYTWkyMGVkKzF4U2p5cWd5ZCt6N2RqZVBw?=
 =?utf-8?B?SG1Ea0VMY1oyayt0WTVuWENUNDk4bVhhZitFTDFGWm5XN0MwZFh0QzFtLzR2?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A2082972B523F4D87850275B3CB3107@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TcynitpE6nam3ZftmwE3t9f5dyEpsMB+Q85ypCKp3l3eoiaUCuu7sIdHcKTxgbMo7QD4JMHkcqfkRLbbaK+XcOI2dLWHJulSFUV5HGljOGJtpSQsfRmeN9NstlpMMEBkUSUqtTFIEWApQN9xcHO6owltUUl88z56qr5kdisJa0cqM6mO65cCbe8Ta4RJQ7BAegQcn5BZ5GbdUW5h/eNAgJ5GiTQRPdsi2akj8rxOJDVGV4SuhA8QBD1h9vMCPnHr2f/YegDMKN9ZX612VHkepg8mrFDoPuWZEClrztHdduR6gmr3SSSqEv/lCiNGyUOfDNhldMNG7OqX72yarafN6LH7hiOCCh1oseIAvC7wZvWV0sFKQ98PzSynpS1BW0jRBmjekVRuCIVgYZmw22366r4l94MUYrIlZkLq7fGJum38FCKKSZhKavSiD3nsfid3oFr6JjXEOsYENHUXBQGYhPjNeQWt2f6qrnsig30+2RpTOIChmPVUr8QTRHLB3jtOleO8uUCQgJbHKBfW7jujVGton0M5eKZ6l+ZaA1PkyjvMeRfKoYX/p9ZmtLo/QkbGCadFNMsSOv2rG+sWZes9yX2SIztwpmEND48bEWUMcAw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e0caf2-f062-4d3a-2852-08dcefbf9bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 21:55:41.3331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LbInjU0y6ZZMCIRb7it7T6x5oYL092ZvTP1vFEgZ04vQ8EEMd2xstX/DPnJSRVW0d0x36Mrztj5GgvUQ4ju4+c+Ph1rHkQkgFUM88fM+bY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_17,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=986 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180140
X-Proofpoint-GUID: isSYRvFe42eKU3Ofc24JGpgK24IXcFYh
X-Proofpoint-ORIG-GUID: isSYRvFe42eKU3Ofc24JGpgK24IXcFYh

DQo+IE9uIE9jdCAxOCwgMjAyNCwgYXQgMTA6NTXigK9BTSwgQmVuIEJvZWNrZWwgPG1lQGJlbmJv
ZWNrZWwubmV0PiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgT2N0IDE4LCAyMDI0IGF0IDE1OjQyOjE1
ICswMDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4gDQo+PiBUaGlzIHdhcyBkb25lIGluY2Fz
ZSB0aGUgZW5kLXVzZXIgaGFzIGEgdHJhaWxpbmcgY2FycmlhZ2UgcmV0dXJuIGF0IHRoZQ0KPj4g
ZW5kIG9mIHRoZWlyIEFDTC4gSSBoYXZlIHVwZGF0ZWQgdGhlIGNvbW1lbnQgYXMgZm9sbG93czoN
Cj4+IA0KPj4gKyAgICAgICAvKg0KPj4gKyAgICAgICAgKiBDb3B5IHRoZSB1c2VyIHN1cHBsaWVk
IGNvbnRlbnRzLCBpZiB1cHBlcmNhc2UgaXMgdXNlZCwgY29udmVydCBpdCB0bw0KPj4gKyAgICAg
ICAgKiBsb3dlcmNhc2UuICBBbHNvIGlmIHRoZSBlbmQgb2YgdGhlIEFDTCBjb250YWlucyBhbnkg
d2hpdGVzcGFjZSwgc3RyaXANCj4+ICsgICAgICAgICogaXQgb3V0Lg0KPj4gKyAgICAgICAgKi8N
Cj4gDQo+IFdlbGwsIHRoaXMgZG9lc24ndCBjaGVjayB0aGUgZW5kIGZvciB3aGl0ZXNwYWNlOyBh
bnkgaW50ZXJuYWwgd2hpdGVzcGFjZQ0KPiB3aWxsIHRlcm1pbmF0ZSB0aGUga2V5Og0KPiANCj4g
ICAgREVBRCBCRUVGDQo+ICAgICAgICBeIGJlY29tZXMgTlVMDQo+IA0KPiBhbmQgcmVzdWx0cyBp
biB0aGUgc2FtZSB0aGluZyBhcyBgREVBRGAgYmVpbmcgcGFzc2VkLg0KDQpPcmlnaW5hbGx5IEkg
d2FzIHRoaW5raW5nIEkgY291bGQgZXh0cmFjdCBhbmQgZml4IHVwIHRoZSBkYXRhIGluIHBrY3M3
X3ByZXBhcnNlX2NvbnRlbnQsDQpsYXRlciB3aGVuIGtleV9hY2xfdmV0X2Rlc2NyaXB0aW9uIGdl
dHMgY2FsbGVkIGRvIHRoZSB2YWxpZGF0aW9uLiBCdXQgSSBzZWUgDQp5b3VyIHBvaW50IHRoYXQg
aXQgaXMgcG9zc2libGUgdGhlcmUgY291bGQgYmUgYSB2YWxpZCBBQ0wsIGZvbGxvd2VkIGJ5IGEg
c3BhY2UgYW5kDQpzb21lIG90aGVyIGRhdGEsIHdoaWNoIHNob3VsZCB0cmlnZ2VyIGFuIGludmFs
aWQgcmVzcG9uc2UuICBJJ2xsIHRha2UgY2FyZSBvZiB0aGlzIGluDQp0aGUgbmV4dCByb3VuZCB0
b28uICBJJ2xsIGFsc28gYWRkIGEgS3VuaXQgdGVzdCBmb3IgdGhpcyBvbmUuIFRoYW5rcy4NCg0K

