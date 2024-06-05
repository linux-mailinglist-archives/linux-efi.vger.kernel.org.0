Return-Path: <linux-efi+bounces-1173-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F78FD62F
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 21:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C543B21D0A
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 19:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029D213A418;
	Wed,  5 Jun 2024 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iFPRVeJu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CMVI5+MI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CCEC133;
	Wed,  5 Jun 2024 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717614310; cv=fail; b=dKOH3L3IbEgi8H7iZSDB3hGzMOC/M0jsYpPeJJsllWpWdlw1WOeQCrgqNhz3IcRrG04YuuzcgEELnyh923aihfP6Flqk802qLbvMEYguVbv2mIv2AtE7TaEIVC6+tlGkp9wJJ6EoLh98B35s9b1wQ/rwDFe+bXbUCBXTSoHsA7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717614310; c=relaxed/simple;
	bh=DBi9jpFfrahX4bItCy22Z5dg/1rxTWGh/IGxy8z5I0o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M2gQPX5b02lp2HnG6feJf4ChUUy1xUcAWtNk+3NIsmyLNkg2MO+s/Jea4ol18PsTltPvlbX6OU7phuDRKW2HH83LjTx9HOclBOHBbpme80mkQaZMU/NBoPImm1GrL0l/XPXlZiEaT3HTl5y44IooOa6kB6T5VlMgmmpYP65Db9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iFPRVeJu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CMVI5+MI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455IwZ8u005217;
	Wed, 5 Jun 2024 19:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=vtT7xa3Cp2ImAocdDUpP9o/E6lOY7CQIKr9o8W6yutM=;
 b=iFPRVeJu2kQMEkvDkDNRrDYwTr1dDbt3B1Bt+i8JwfZ1OgYRFkApuF5qBrUe37wNPVA8
 4czZdFr4R0AUKqjAtHGqFiI99QanmX8Wzu4iPZ89opNCNDTFKVe15MIRZ5kcnZ+pO8XP
 4vc2mYR3/tkEHfALLxk2fDzsl8Kuv5DIptFfZKIKJLp/yv3fDk7+qnkrbgWNIWp3miU1
 NoBWjIr7BZXP6AYSK+XbmXxY+qHgkh5CGE6qKCWM6yxDLDVCsAM22I1g6BV/0sojWgIP
 hcR65ZGERmzA8u80CfvT6zNQL6aAbUf4/FkLpxOo1caTSypJhlgm70em6j5b87HxHprv 2A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrsa1nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 19:04:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 455I9xrV025123;
	Wed, 5 Jun 2024 19:04:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrtafkwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 19:04:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvSv28V8ytO9R/2UpxQA+rbg0jbotyBsJqpYrlEJA0avtoTa/7uTfo3sK/uBaO7IAg1//Iolmq6TJ6mqukwOd/2oVdnSur4ltntrg9hoPAy8IYZ0oPzGY7bIDMLPWRdAWACR4+Iw2PCDNTrVSSyW1SltSHkOG5d8aXGwUrjqQv9GEM6JhYj2mWtHE76coyvZpqnZFd3vPH/9QcUiHV41aCW1yvSIsrpfIv+q//Pg6irYDFuR0WbNmVjjhkagkWk+nJdtEyFyansQvxPPHlCcZrQw8HQQHk1j4wi0rYTiDIUgcW/tSLP12u2cAOcMxmTFxcE8KkwmmWH8xGkzqITOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtT7xa3Cp2ImAocdDUpP9o/E6lOY7CQIKr9o8W6yutM=;
 b=bSSxV01tNvGO1ktKO3zStMcY9Ief2eT9GDQWo6B/Vh10LvdNCh/UUvkFgv0ljnt2h2ytnBmqllmFWhhAg5k+9WMeBBLrFw5h3lzaKWMXQ38ZTm4WdMoTaUJNxAUTIampwHABJy8fi8uQCntVu+X473ZRA2QY9+Tvhao4I9ji7OCSRr2YH34mWkCarXbd4i/TWMxEiE2NDYNv+9b/gU3MFyIXmLzwBZF6SXKbHgcbbvxl1ZrxFM3Oy178nZY0KYsyaILUy26DECNg29pojTvjP7PPSVdrpEqIlnvH8FsuBYOhPhOhFIY61vd2Kc92NsRH+ODQgWngBaL7noF2cIkTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtT7xa3Cp2ImAocdDUpP9o/E6lOY7CQIKr9o8W6yutM=;
 b=CMVI5+MIIG9ERl07xQrhutrZzR3kBaBAxpV9XFalRVk9CgZtENb0hRENrNgJ3wTSwnuGHJjuTyyYExJD8BNZSruPbiTozJSmgDezcdLPY0RfyAqPk4VqrfETkgPZFJwidc2GYItgvDsKyaXHPJ+cDx/ZP/mTb8mhhO00GrgYfCk=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.31; Wed, 5 Jun 2024 19:03:59 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 19:03:59 +0000
Message-ID: <a865a25c-336e-47de-9718-de4cb957e6c2@oracle.com>
Date: Wed, 5 Jun 2024 12:03:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/19] x86: Secure Launch Resource Table header file
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com, ross.philipson@oracle.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-5-ross.philipson@oracle.com>
 <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
 <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>
 <D1RLBMTUKRFN.34KQXEFZTBA08@kernel.org>
 <249a9b27-c18d-4377-8b51-9bc610b53a8b@oracle.com>
 <D1RNKV4JIE5L.1LNG82UAC916M@kernel.org>
 <f66de08f-4905-48d6-8bcf-5b1ab847492f@oracle.com>
 <D1RSB1PB5XGS.2X032M0E1VMJW@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <D1RSB1PB5XGS.2X032M0E1VMJW@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0036.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::49) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ccfc01-9056-4aaf-7e1a-08dc85924185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WW9aSlF2NXgvS3JPZXFSaWhpSXZQVURSOXQwOFI3VG5pMGw4M09mbDVwZU9B?=
 =?utf-8?B?SVdvRk9pRFVpTkIzREZrRVFzc3NYLzZZVEo5Kzg1WjlCR3IrSzgzY2J5S0ZE?=
 =?utf-8?B?b0xOa2d1L2pKaXlnVWJPWUxsWURPeVBCKzRrYTVyZ20vMTd6RE00aTEyMWlz?=
 =?utf-8?B?NzBIVlRyYXN4SEVNaFlvOUxvdFBlRE16bmMxL1MzZm9WOE1IdHJiT2xkTVFu?=
 =?utf-8?B?eFoyajFzLytEbmkvODQvNGxIbDNsY1lYN3dPQ2lMa1FLaWQ0Ly90WFVxanVv?=
 =?utf-8?B?WmRuZDQxeEp1R1FUZ29KcUVWMHhMQkZZZ2hDcmk3Z1A0YUQvc3RMMG5nNHJ2?=
 =?utf-8?B?V0FWa0ZhWk1ueFZ3cUdIK0trQURmNmxxKzNMTUJMOGRZcmZCUDduMXFlc2lU?=
 =?utf-8?B?d2lQN1JML1YwRHRDNU5hNlhoY2tGV0xRMisxMDdFYmF5MFVLc0V4L3l3OXA1?=
 =?utf-8?B?VzZtR2Nydy9veC9uZHM4TCtCUldhNjBKZHMxK05jNDNaZ3J4T3RZZW5JMmpV?=
 =?utf-8?B?a0hDcmZjczVtZUJ0MlVnL2pxWmd2MHo4Z0g2MU82R3hEdmgxc1pHZW83Q0FJ?=
 =?utf-8?B?L2ljZWhkM21XUExaOWNFRnMxUm00MjZhVDJmNlBmWFlNMmpMTkRsbXBEOWtt?=
 =?utf-8?B?M0Jhekh5UVYrcVRQNEFONlF4alkxTjV4K0kwSUZQYUoxdzA1Q1ZyNFRGRXN3?=
 =?utf-8?B?ODFWOEgwaEZEZzN5RlhGRWUyNEsweHBxamdHS1F6eFpGZjN3akY5cGFZS0k5?=
 =?utf-8?B?YXJoQ1RvZXhMVHFBMEZuY3NoVzlVTEtZWFk5VGJNeVJGY2dsQmxxeHoxTWtJ?=
 =?utf-8?B?WUtyb3dlRkRRQzBDOCt0dU5adWYrdUx2VDl3VHJxRU1sTCsvUmdKTjhGS2pz?=
 =?utf-8?B?TlprS0NQQ1ExdGV2QWhnenYyQmI2cm9TU1REcWM2bFFmYnRqdDhPODZoYndD?=
 =?utf-8?B?cTlQNXcyN0w5bVcveUwwRlBxdWttUUd0YUZhcGFwbXlIbXBpdHBkZDBiRE9p?=
 =?utf-8?B?OU9DN2puODh4bld0WHRHZFhzdTNsdVFyMEE2TWhja1p6K2QzVVVkMHFpbDY4?=
 =?utf-8?B?Zmh1K3FQUWVVOVVFZlRSU3ZycGx6U0drenQzMDBEeWNvbWhmRHhlOEoxVG4x?=
 =?utf-8?B?Q1RBNXJsWTZEQ29yWXJwRElHb1gxS3BMeW13RmpBbWVoVGJRdmdodFdXV0p4?=
 =?utf-8?B?K2ZSY3hMZ1JaeGJFRzFhMDR6dnkxd3JHQlk4SmtLZGRJWG9CcUFqYnBBZWZl?=
 =?utf-8?B?a1JoNWF1MDg0VmZraXp5WXZPMmlVUXZOM0lreWN5RTdUSVk1eTNZRWVucVl0?=
 =?utf-8?B?ZkFUa0prS1hWenNyOWFZK1Vhd01OMEFkM2FKdDlNdnRpSDcxemg1TzhIcW1r?=
 =?utf-8?B?ZjRsN3RzdEpoVFo1czFneFgycitsWGUvSGIrM0dUQWFnNkhDcTRRMWNUQmlm?=
 =?utf-8?B?c1FQaVB4cVBXZkVYZ3pjUGpFdDV6dElIT3FiLzREaDJ0Ui9JWWh4c0FIQlYx?=
 =?utf-8?B?bnNXa1JzNGFUVVBXekNodW1ZZnYvOThVSjdGTkxldFhWQzBQeGxNOUJiVStP?=
 =?utf-8?B?QVcva05OVnd1cXhJUlBrV0ZjelJYR0F1UkNJUjZTUFBWS2thTmZ0TjV4Z2xB?=
 =?utf-8?B?NitvRDR5QjNpb1lHcUFLZG5IUkQvcEVTZUhkTlFseFFpRG91Z2NrRmR3YmlX?=
 =?utf-8?B?OTJrSVlHM0xvTFliMHdsWExpUGhGSGd0RHhyUWxWQVN3R0VGcitCeFpIdG5m?=
 =?utf-8?Q?xQtjGwpvZNQo1J1fpV06jkRl9QkZ5m8wAD7z/jH?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?enJaVkd6WTYzYVgzTERJZFBCankyMk9ZQVo3WURudnJiNit0eFdKWjgwL1Fp?=
 =?utf-8?B?NDFpLzg4T0hhYUZQejV0Y0xxbG5FQnRFYnk5cEpoTk8yckh5blM5anhiV3Zi?=
 =?utf-8?B?VXJ4ck9DMnhFeDNGTFRtSzdVTjBUMDJEVE5kcXBWaUlrZk9HTkt0QVppbEc5?=
 =?utf-8?B?Vmg1STNlSkErdmdrMW01RVZra3l0NTdHRnh0TGlYdG5IS29ZYjdUajZpZUcx?=
 =?utf-8?B?TWhrRm9mclpqeHhUb0VaWXRGMXU2OElpbmJrbDRXdW1EK2NEZVV1bCtwdC90?=
 =?utf-8?B?WjlMS2xWdnE3clhiY01TZGlTeVkwUXRSc1pzRUFUWFBjaE5rZ3RtVzBHcGhI?=
 =?utf-8?B?WlljdnlYbWV6VldPQ280cTVZejRGbDNXaDRmWHVBS2pyU2hxa1RITlNHckp5?=
 =?utf-8?B?T3AyRlRWMktLL0taN3FPR0dQcVY4N2FPMnJpTUtyQmxERmVsOU42c05BWHls?=
 =?utf-8?B?WVkzcFlXdnZpYkkxb2JsNUVNbEtmalJPRmJEVWdqUW5XN0FOdFJOLzZiY1RJ?=
 =?utf-8?B?MWFoNW1GRHhVM3VEZ2RBaG9BK0dDUGxuMFcrLzRVamx3T1RtQVlGS3FhUEpK?=
 =?utf-8?B?ZkhFWm9JTFloKzFxSmsvVUo5bUo4b3FBYjNIR0tzOGM5dU9HeXlZdC9JdVRC?=
 =?utf-8?B?S3YvSnFVSEdaL1lIRElOTXFwV3ZERy9MUTlIOUx2dXVrSlVQUjN4WjlyQmNm?=
 =?utf-8?B?WXl2Qk52VmlJa1BpYXZaVFcvK05SR096UExVMnVYN2p0Q2dQSWtkS1BJckRV?=
 =?utf-8?B?dk1qL052V0tPVlFtKzEvUElLLzJDcnAwRExYKzduSEFjajA4M1BqNlFMWVRO?=
 =?utf-8?B?N0FxWGt1T2RjWnpGa2Mrbko0S0NYeUt4YmVscUx2b003QzFyT0FnNmFzSXNn?=
 =?utf-8?B?NHliVVVsZm9vcXIrS0I0TC9IUEcybCtYN0phNHR0bnI0ZVU2YUtSNS9vNTRI?=
 =?utf-8?B?UnR5QmRRdFdCWjlXZGFCKzVRNzkrUFc0TTNIMU1vOHJQekZyOU1raCtxL2tx?=
 =?utf-8?B?M0J3TkFUcjZIOXRNYWMzUWV3RzBEWVltbnBYSm8xaVB0cTVvOHNoSlhueW0z?=
 =?utf-8?B?a2RVOGRvR1Q1b3lNL2I2ZmVjQlJ5ZVFJRHprT2pjOVZTVjhYSTdRaVhYQmJY?=
 =?utf-8?B?Yk55WWMvVlI0RmtVS005ZjQ4dldHUXkxZXZ1SFFVSVRoUFBHMkorVlNsK0VC?=
 =?utf-8?B?UExlOVVMc2hpbmZXSDFJMCtUQ1djcmh4aE4yT0lZVnpiZGJkUko0cStVaDVZ?=
 =?utf-8?B?Y2FUeTZpMWd4M2pFakdLR0pIUmdES3g1elNBOFRzeTFYbk44SEhwTnBmRUEw?=
 =?utf-8?B?dDVwU3E0c21oSHVwUjdkcEg5eW1NeitZV3ZlRWphazB3OU5JMTQzSEpHYk1N?=
 =?utf-8?B?bGo3VElhRDl0S2JLbUJMcldZc1FaTDAxQkRJeHpVQ3I2UGpnbEdJV3U0b3FL?=
 =?utf-8?B?TW1KdTZGb1BhYzlScE5yNnk4djJMS1paa1RaTGRobTIwcUpzc2N3T1hQNzlJ?=
 =?utf-8?B?a2NxUWd5VVFZQXRZMC9VeUZqcnpFOUZkWWJBa20yREFqWVpjVEk1L20zVGt2?=
 =?utf-8?B?OUhzd0QzUTRCMGJJTUhFWWV4eHdoVFJxNk0vLzRqN0Y4YlFva0E4cGhIV01S?=
 =?utf-8?B?UHphYmJoNlE0OUJ4aE9idjJ3aDRzd3hiTm9Ganl4bTFNR1o0ZkpUZEduNnZj?=
 =?utf-8?B?OHVtaVlNZ0ZoUExZN0FyS0J2Z0dMSS9CV0hqdGFUMzBmWG1oVVNYZWRoeEFa?=
 =?utf-8?B?RWFNZWlid29USmw4K1JQcERWMjlwd3hkSHIzekp4NGVPay9hTUYvQVZNc3Rj?=
 =?utf-8?B?Ry81NmhPWVRxL1Jva0M5dlIrYWNXUFVBSVNBUkhtL3BJN3QzbkFZVVhYQ005?=
 =?utf-8?B?bzRHTXZYT1pwbkZBb0N6KzhWVStxWk1KbDN3ODdWVFg1eUU3K2ZLbmpDYm5s?=
 =?utf-8?B?anRveEhzeWx0SFRUM2VhcGl2N2pWRnh5NCs2cVpPNEI1SDRiNjBFa0Zzc2FL?=
 =?utf-8?B?QVA4cmgxbVh6TWVwQzlxODh4My9tcW0wWTV1QlZYUzNiYjd2TUhjV0hCcnlo?=
 =?utf-8?B?b2VvU0VFNXRrQ1R0dk5FTFhCQWY0UVpxOW5NeDhhT3lzQ0R6Qm1ubC9rWStZ?=
 =?utf-8?B?MjhBTy9wQjJGN2JlVDRqdTBwN2RSMzhGTnBaWWpodmNzVHhVUFhNcy9VR0NW?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rnkLk/BVG51lOp3o24lJvTxpOup36ynvh6pBJ7OqP4H2VoxtblNtvLXX7wgJHRSE9882rnoOjzOgMklfRr+mN2j50DU1SnrXOZpnMJrUNav78IfcCHEJrJahZ7fQ+Qv9oWECqkV1CNAnrQEN27kO6RVdncwiTxNscnabCBRVAoQBSr7y3kodwcE+eCDW+AnMOPqjV/SyYVf3NC+mumD2d+ks0qKZaGPvCW0GryRZI4DXVfcypXyDjJ1U1FyKL0XX0ZvfcN6dU1xIdHNddokXXJSWdpR+qwYb2NeYYlwVqcQ1olBx3Xnsy6tsJBKZLjB8qR8lyBEnisbEehvRXWvEM/hbkPpK8stCQaSLXuE3hoVK0Z6288D297jORSEYyhHDxJolVNzXgGk3xacRLvbfOxh+xgDtGe5USYqjQmbJuSSmrL/lenqrSEGKDsKcncrUB/QfMkrI7bLYElRFFBTmcdcTyx/eya8jnV2E0MIjxUcUVAezhzRIxPg6itZHn5rG26oDoXGvyKRIj8fGEBO3CZV330OzEJCOEVH8abJoeif1P1fOKGUKSH722DC8gE5Rm3rOov5EliaclkUdLcoJFimhSbpqjRSBVza82m9F+0M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ccfc01-9056-4aaf-7e1a-08dc85924185
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 19:03:59.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MtYl01tHrAvpIDR6nB1ALH/vdtgi1N6qyZJ/PCi5DCBI+r2yyKjIBdOsb5pYfc/k51q2t00Dus5xIlAdM2eSORq4n3yQzI4nUsuTXVx4c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406050144
X-Proofpoint-ORIG-GUID: xXfCFApUQ5BQfMPqdWGHFOIZS4sLHcGl
X-Proofpoint-GUID: xXfCFApUQ5BQfMPqdWGHFOIZS4sLHcGl

On 6/4/24 9:04 PM, Jarkko Sakkinen wrote:
> On Wed Jun 5, 2024 at 5:33 AM EEST,  wrote:
>> On 6/4/24 5:22 PM, Jarkko Sakkinen wrote:
>>> On Wed Jun 5, 2024 at 2:00 AM EEST,  wrote:
>>>> On 6/4/24 3:36 PM, Jarkko Sakkinen wrote:
>>>>> On Tue Jun 4, 2024 at 11:31 PM EEST,  wrote:
>>>>>> On 6/4/24 11:21 AM, Jarkko Sakkinen wrote:
>>>>>>> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
>>>>>>>> Introduce the Secure Launch Resource Table which forms the formal
>>>>>>>> interface between the pre and post launch code.
>>>>>>>>
>>>>>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>>>>>>
>>>>>>> If a uarch specific, I'd appreciate Intel SDM reference here so that I
>>>>>>> can look it up and compare. Like in section granularity.
>>>>>>
>>>>>> This table is meant to not be architecture specific though it can
>>>>>> contain architecture specific sub-entities. E.g. there is a TXT specific
>>>>>> table and in the future there will be an AMD and ARM one (and hopefully
>>>>>> some others). I hope that addresses what you are pointing out or maybe I
>>>>>> don't fully understand what you mean here...
>>>>>
>>>>> At least Intel SDM has a definition of any possible architecture
>>>>> specific data structure. It is handy to also have this available
>>>>> in inline comment for any possible such structure pointing out the
>>>>> section where it is defined.
>>>>
>>>> The TXT specific structure is not defined in the SDM or the TXT dev
>>>> guide. Part of it is driven by requirements in the TXT dev guide but
>>>> that guide does not contain implementation details.
>>>>
>>>> That said, if you would like links to relevant documents in the comments
>>>> before arch specific structures, I can add them.
>>>
>>> Vol. 2D 7-40, in the description of GETSEC[WAKEUP] there is in fact a
>>> description of MLE JOINT structure at least:
>>>
>>> 1. GDT limit (offset 0)
>>> 2. GDT base (offset 4)
>>> 3. Segment selector initializer (offset 8)
>>> 4. EIP (offset 12)
>>>
>>> So is this only exercised in protect mode, and not in long mode? Just
>>> wondering whether I should make a bug report on this for SDM or not.
>>
>> I believe you can issue the SENTER instruction in long mode, compat mode
>> or protected mode. On the other side thought, you will pop out of the
>> TXT initialization in protected mode. The SDM outlines what registers
>> will hold what values and what is valid and not valid. The APs will also
>> vector through the join structure mentioned above to the location
>> specified in protected mode using the GDT information you provide.
>>
>>>
>>> Especially this puzzles me, given that x86s won't have protected
>>> mode in the first place...
>>
>> My guess is the simplified x86 architecture will not support TXT. It is
>> not supported on a number of CPUs/chipsets as it stands today. Just a
>> guess but we know only vPro systems support TXT today.
> 
> I'm wondering could this bootstrap itself inside TDX or SNP, and that
> way provide path forward? AFAIK, TDX can be nested straight of the bat
> and SNP from 2nd generation EPYC's, which contain the feature.
> 
> I do buy the idea of attesting the host, not just the guests, even in
> the "confidential world". That said, I'm not sure does it make sense
> to add all this infrastructure for a technology with such a short
> expiration date?
> 
> I would not want to say this at v9, and it is not really your fault
> either, but for me this would make a lot more sense if the core of
> Trenchboot was redesigned around these newer technologies with a
> long-term future.

So I did not mean to imply that DRTM support on various 
platforms/architectures has a short expiration date. In fact we are 
actively working on DRTM support through the TrenchBoot project on 
several platforms/architectures. Just a quick rundown here:

Intel: Plenty of Intel platforms are vPro with TXT. It is really just 
the lower end systems that don't have it available (like Core i3). And 
my guess was wrong about x86s. You can find the spec on the page in the 
following link. There is an entire subsection on SMX support on x86s and 
the changes to the various GETSEC instruction leaves that were made to 
make it work there (see 3.15).

https://www.intel.com/content/www/us/en/developer/articles/technical/envisioning-future-simplified-architecture.html

AMD: We are actively working on SKINIT DRTM support that will go into 
TrenchBoot. There are changes coming soon to AMD SKINIT to make it more 
robust and address some earlier issues. We hope to be able to start 
sending AMD DRTM support up in the posts to LKML in the not too distant 
future.

Arm: They have recently released their DRTM specification and at least 
one Arm vendor is close to releasing firmware that will support DRTM. 
Again we are actively working in this area on the TrenchBoot project.

https://developer.arm.com/documentation/den0113/latest/

One final thought I had. The technologies you mentioned above seem to be 
to be complementary to DRTM as opposed to being a replacement for it, at 
least to me but I am not an expert on them.

Perhaps Daniel Smith would like to expand on what I have said here.

Thanks
Ross


> 
> The idea itself is great!
> 
> BR, Jarkko
> 


