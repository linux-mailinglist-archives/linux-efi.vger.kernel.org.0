Return-Path: <linux-efi+bounces-1471-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BFC9381D8
	for <lists+linux-efi@lfdr.de>; Sat, 20 Jul 2024 17:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019D91F21327
	for <lists+linux-efi@lfdr.de>; Sat, 20 Jul 2024 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92691311B6;
	Sat, 20 Jul 2024 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="vaUIQX+p"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D9C8003F;
	Sat, 20 Jul 2024 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721490492; cv=fail; b=U/8pIEUQETy/fAu6wusR9E4l88Gr+OeMMo74+9w6o2pPXEbvh9bqsMW3MYeSJWn/uUtV+ZbzALahsNZ3ZYj0VtFiXQlYxXjUIZxgW3CKZYzKA0bZyVHq1YgVc4TQSFNp685j6NLQUO7SzfcbGXnDwNnQUb6+E5K/tTaq/lZE2zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721490492; c=relaxed/simple;
	bh=0OEhddbFz+iRrdRlvRbIznWS0+ejAC7usQeCom4DehE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fOxepx4+/0n/GYCCLNY40nAwvQIQLAnye2uuH0wjdDC/yJCxbIhGsr1Jg6Xd5kBZLSDmAcrX3VcDMpRLpahu3+pJoPXbOJPrMjrdRoIFyZlgneRfpLS+k5zQtI+rPWI0FGNjYWuJCseDYHVeMXbfJmvm5PRumHnkSLhHZV5TjZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=vaUIQX+p; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46K6FXuR005428;
	Sat, 20 Jul 2024 11:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	smtpout1; bh=0OEhddbFz+iRrdRlvRbIznWS0+ejAC7usQeCom4DehE=; b=vaU
	IQX+pxx3cmB/bXQW10Si3a5mohTaVPkSgN78rRUDX5WwO3WMFNZsgI+0U42WxSE2
	nB6FYtgWvjeB64fjb09Qcu7wPKvc+Jf4DRQI8g2cYUSA1F2V+OUzDJzOX3zNNM37
	A9uS2cGO+oV5FIpxcrIR6eEKaoMKyjhpyVBL0PkVvIkP5gqSYyN5GYUfhrCpdxkO
	z1Hoi7kgpkUO1A5TY+dO96v8Y+qjTgVOr43ocgxsV0D02Mc8RLkONqR+czx2uMnH
	We6cgPwtwpEZvmeubuAULont3Kn1/v1+Lsl1dFVwe6+BXsYjheeMMdPnTrU19Weo
	QDsLNy9YIMUtikHQ0mg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 40g7t2h05j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jul 2024 11:47:33 -0400 (EDT)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 46K6DacN010540;
	Sat, 20 Jul 2024 11:47:33 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 40g7sf3p4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 11:47:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRz2+iyv+Edy0QOt1QIcQUPRWrZyDfZyhGjXERQRXzmIPsfytmyUarHnYQXxvSuAaSASWNLOzPx/1+gWAzW/8Hb37ipcpkJ6ZKFYz8+LmXAtMs2w/zqlbhCxSp+l/OsENe87YsmGz+snJR9b0aiTX73ZXGK6MSaQoV/QdVVqE0GxFHHrP5J6iThaAKJWoiyszkIRX27mijU+Goxcwt+kaOy+aHuaTR2dqzHXo/LKgNvDqecOnRAjooGxzhuCK1io5rA3qZtywfcGj3P9vw3blaG+haNKnsrQ9TcyzsNX3djq3lKkoltZavh97DGfXC+sjjyEaNaaUZqjJ71BCONySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OEhddbFz+iRrdRlvRbIznWS0+ejAC7usQeCom4DehE=;
 b=j0N48suQUv5avYMslhBRKQqsjFctY/n/HRwj5iEgulqdmXEnjpfsg5NGayRbars10w171nCbsxZNtenHSwdwe87lLsZ70Ex/EL1wlAcg1Dy8at+oIDhORz0dialNbVtAZO+otFLLYw+CIv6T0Rv8Q/if+WyZM+9mkZHYW6/MkCCJmHemL1iudbFdasonZ12DBD0sXzjVa/EMWZVIh0RRFshCKTjFXXuTbGnSINJwAtYUnogTKqxjCBEzLak4ihMI+VTIWiyjQMfuOMGaCVPVn3JgqnReBwYeDkKIZ05/rhRQGdPQPoP6PxODTMl2UWGFfSlBKfiD7Hpr4CDQmWAk5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DS7PR19MB5709.namprd19.prod.outlook.com (2603:10b6:8:70::15) by
 SJ0PR19MB5477.namprd19.prod.outlook.com (2603:10b6:a03:3e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Sat, 20 Jul
 2024 15:47:28 +0000
Received: from DS7PR19MB5709.namprd19.prod.outlook.com
 ([fe80::3d06:d879:7717:36e0]) by DS7PR19MB5709.namprd19.prod.outlook.com
 ([fe80::3d06:d879:7717:36e0%5]) with mapi id 15.20.7784.016; Sat, 20 Jul 2024
 15:47:28 +0000
From: "Shao, Marshall" <Marshall.Shao@Dell.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "ardb@kernel.org" <ardb@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de"
	<bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de"
	<tglx@linutronix.de>
CC: "Mishra, Ashish" <Ashish.Mishra4@dell.com>,
        "Dion, Christopher"
	<Christopher.Dion@dell.com>,
        "Caisse, Joe" <Joe.Caisse@dell.com>,
        "Chia, Jia
 Yuan" <JiaYuan.Chia@dell.com>,
        "Mukundan, Govind" <Govind.Mukundan@dell.com>
Subject: RE: [Patch] Do not clear BSS region in x86 stub
Thread-Topic: [Patch] Do not clear BSS region in x86 stub
Thread-Index: AdrYGyaFCseU4QE3SCibBf0Ev6R9+wAvrfKAAHh+C3A=
Date: Sat, 20 Jul 2024 15:47:28 +0000
Message-ID:
 <DS7PR19MB5709E3E075A2E77A75DA240C8BAE2@DS7PR19MB5709.namprd19.prod.outlook.com>
References:
 <DS7PR19MB570996A580C6F5D2C9CACCE48BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
 <A2AEC38D-56FB-4687-BDC2-54F1600F14A1@zytor.com>
In-Reply-To: <A2AEC38D-56FB-4687-BDC2-54F1600F14A1@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=81310eba-b5f0-4161-8b9b-c1e02a3b3312;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-07-20T15:45:25Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5709:EE_|SJ0PR19MB5477:EE_
x-ms-office365-filtering-correlation-id: 6d9491be-2e21-4544-df96-08dca8d34275
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFZZODlCNmowVU95SUtXOGVGcnB6MVM5bVEyK2J2SmlBYjNiRWpEQUoxb3pz?=
 =?utf-8?B?YnBnRjdaUE1BS0VqTERWdXBGaU00UFc5NEVUYUoxNmdYcVFBU0hBOWtTNVBU?=
 =?utf-8?B?SHJreDRrMFRJUkI5RlFSdHA3UGxoK3BRRTVoY0J4TEtGNStPMG8rNzJyKzdy?=
 =?utf-8?B?M20rdS9wUlVjZ2RlSTVQQkt4aE1ZWjJ0MFZXSDJaam1Oc0RibGFrNklnem0x?=
 =?utf-8?B?aUVpQ0xhcm9QVkR1NVhOcTVSb2ptekg4RlVZbGpnTDVZeXRUK0VHczgzTHVw?=
 =?utf-8?B?bm5RVGRGWDlCbDZ4RCtXRG1uem4yOVRTclAvaENQWTJTN0s0aXh5dnFJcmkz?=
 =?utf-8?B?RkRUWTRrczNQb2llUlExUWkrTFplSmVvUU1yRWk0a09VVWVGamFKUFc1UEly?=
 =?utf-8?B?SWlzYjkvdURKSjFXdDU4L1o3cHN3TWRoNjRFZysxS3ZJQUFLcHFaMjJ5ZXY3?=
 =?utf-8?B?bGIveXhEUmtlakhIQnVyOTVsWDdWTWc3MzNmTWhBWEM1enV3VTI2TjB2bGV4?=
 =?utf-8?B?bmd4VHlEUXY0MHd2Zk5XellsSGZiaGx1Sm9LOWlMbGQ4MEFLWWRQcHhReHRh?=
 =?utf-8?B?UFYwTC8xbXgwbk13MU90bEFUK2l5aXNSK3M1aVNNOVlVVzhBUER0WGdpZUp2?=
 =?utf-8?B?akNISEluRm1lVG1JdGh0TXB4RFZJZU9pNEUxYjZXSDg3enZEK01EbUZLcnZY?=
 =?utf-8?B?T2wvQUpJWEZWM0xHbU11eXV3NEduQk9YYnBRQm1PSEc5c2QyZWxPOXFLM1hQ?=
 =?utf-8?B?NnJJOG9IS2sxcjJEYnpNVFJNeTU5QStkOG54Uk93NE1iK2VWVEN6RkVLOUFP?=
 =?utf-8?B?cHVPSXFBYzF1aXJ1UmdqUVg5L0FaNTBpZVE4djh4eS92R0VZWmR0VTM5K3lQ?=
 =?utf-8?B?M0s4aUZ2YnFPZitaZ3h3WlNvckRSdXlxT2FLNEphdXlVdDdNTkxFWmU4RHVy?=
 =?utf-8?B?enBkcmJuUWRDZjZkc2pGU0dtQUxZNkNzdE9YYnUwQzRabFAvckJQSnRtL3Bm?=
 =?utf-8?B?Zys5L25qWjd1ZG5aRjJad09GSmczOWdoK2w1YUl4RTNmbFdDZXJvZmFpUzQr?=
 =?utf-8?B?a0ZkNFduMGtpc2wrblovQ2JjWlpiU2Z4UjVzZW9BMWVuM3JLR0J2YXl5V2t5?=
 =?utf-8?B?dnJpZjNKRWhVZXh6VjN6enRHVWRVa0FpK3lHVE0xN2NDaUxpTFFuLzUzWG80?=
 =?utf-8?B?cDI4ZFF5anFRVXRHR29WTEJtWlQ3V0ZySFJjQmw0OFo3Nm9oQW05TWlSMlIy?=
 =?utf-8?B?OThaYk1SRFM4MzB5LzExTlVQVzhYQmpZNWtocVhtUzV1M2pMTkd2ZVNnMFlQ?=
 =?utf-8?B?MUdiU1VnNzVCU1lSTUYrVHZZOWtZRXRoL0M5N1ZHMHZwdFIzVy9QYmJqMG9i?=
 =?utf-8?B?VHFnL2dkY1NuczdiT1hPLzFwUEdoanZHa1YwY1pTWEYvYUpXSkZaWTBDa1hW?=
 =?utf-8?B?Y2hjSThBUmQvTURkV25IY1F3TG1neFVyT2VzWVBVQUZmTHh4TUtkZ2hPellM?=
 =?utf-8?B?Y1Z3ZW1vNElYTkIyNGJtTWh5YTVoWllSTEFWQk9sSFhEaDNzRUQ3cmlkdHVS?=
 =?utf-8?B?NzdHODFLR0Y5U0djNjRYTWpmTzQ5YU1YSGc5aEdWcmNwZVVnNDA1RnFpRWoy?=
 =?utf-8?B?eUtQQVhscFl1SGZDNWlIOGticHNLV2ZUdXprSzJOS0QwTjc1ZDBjVmNrYXd4?=
 =?utf-8?B?dXJDNmp4b3k4TS84WTU0ODN5aE9nUDEyNzhRaStqUHRqNlFUSUdKOVFGdkFk?=
 =?utf-8?B?RWd0TzBoM25zV2NLdW5rWnpUS0ZvWjkwZlFjM0lXRzEyNmJaS1o4RS9OdHNp?=
 =?utf-8?Q?KfBsdHNgE9cJPh4As98UpoLDTt8J/X22GmlaM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5709.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tnk2aEdrbG9idGZ3dWlISzNVMnFDQXBLLzRXWXJrZkhzQTN4S0NDSU9tNUl0?=
 =?utf-8?B?UmsvWHcyMmVGMktMTm5JLzhwUU9taENySkRjZzBpYk1HZ1dGV3R0OUUva1ZM?=
 =?utf-8?B?L2NPS1cvMHhHYzMyTTNvYU1JdEkyVkJOd0o0UVR1cVU3cXBmS0VwU1RsRlpQ?=
 =?utf-8?B?eGIrTUZHRUxiUGxMV2FqRkNrV1lUYkVXVDVQbEVuUUY2cisrYXpxaTIvZHc4?=
 =?utf-8?B?M3lwc0F4aXQyZWloc2syTlowMGRiQ0luNng0VmtkZ3NXSzdtRlB5dEI1NjJN?=
 =?utf-8?B?R0N6STlBOERadFViR01wUUtzNFNJVlBXWGZkTHdCZ1J5VkZIeEF6SDNQQ1Y4?=
 =?utf-8?B?b2trcFlUZk0yNEZWbDlEYjltUzg4SVpLcWVZVDFJa0JUYWs1SkVDTjg4ZGNa?=
 =?utf-8?B?M3lsTXdyd01Gb1oyenlGREVUeTdMRlpydnFtd3I3aDkyR29DMk5JNUhoSlFv?=
 =?utf-8?B?bUpoUTErOERld2Jkb09RYTV1YU5tMEUwNGp2SWZObkNhVTVNSXFIMDZ2QjM0?=
 =?utf-8?B?RmtLZUxTVDdpMXM2L2pQY2N6LzhvdmE1RS8wTnVic0lPc3ZZdU56Qk8yS2VF?=
 =?utf-8?B?YktrUEwvRXZIUnJZZFV1UnlEV3haUUZtV1VMMVRzOGxFZVlJK29ZZWRmRWVS?=
 =?utf-8?B?ZXp3MExraUFMWXVpa3ZFQ1hwd2ErbDJlenAvcVVEbkZHNGs5VHFvZlhTdERJ?=
 =?utf-8?B?TFlQMXRCelpRNnNHYmRzd0F0SWtoc0xIYkNuNE9PR3F2Z0FYOExJL0NYT2Yx?=
 =?utf-8?B?SFFvYTBFM0tTajc4dnhKdlZiSllLN04wNjJ3SjJmOXRQaGpncndHcnE5VWti?=
 =?utf-8?B?K3gzcDdXMkprM092TFNDMnUwNTZDWElxdDhIZ3RvWGVzdlBKS2p6L21xaDdx?=
 =?utf-8?B?cmFHcHZQNlpiUVJpSUFrQ3NjT0FWQlpxc3M2SVhrbmE0SkFMMitPWnp0bEsy?=
 =?utf-8?B?VUR6QVJ1cDRVdWEyWERxOWVvYWNTRHl4MmdVYTdPeXcybjNMQlNXeU5wV3Jv?=
 =?utf-8?B?Wkx5WExRU0NWUHlWbW5TSDNyUnRuVWExaFlWVVJQa2plRC9SVkVLMjZxKzFN?=
 =?utf-8?B?SFBpMUJOcXllK25aWHVNQU9rQ05naUxtd2VCeXVrTUx3TU5FRmxPSjFwUnFr?=
 =?utf-8?B?bjhLVVBjV3owQlRiRnZmL1B2VGZrSkFWOTMyZnRVS2FmN3JLdDMyT1FsWW1j?=
 =?utf-8?B?b01iNVUxcjdkWk9VZDlMY2pWdE5TTjk5WGQ2cFlKRXpZTFhTWmVSSjRWaGhV?=
 =?utf-8?B?QVdKcm10UEY4ZmdNdlN1L3cxOE9ZQnp2L3NqalI2OVdWemEwUnEyTVJaRm9N?=
 =?utf-8?B?eXFxUVUwcHZQYnhXV3V3aVFoTW5VZnVybDd4ZXM0YmQ5Ky9QbHRYMXA2aEpV?=
 =?utf-8?B?Z0tpbmF3Qzg1V2F2MW5DdkxhN1JOd1pFaTNHTTMvc2FkWk9MQW1DaG9tT01J?=
 =?utf-8?B?eDVNS3hWV09vNGxrQUgwMHU2aVJCWVBRcHBIYWNodzBrRk1qdlhJdjdoOEM5?=
 =?utf-8?B?QmVPeFNtcDZSRXNaZFYrZGNtak9OOVlWbnM1cmZSOGNmaXo0ay9ESk1Cb1M5?=
 =?utf-8?B?TWFhK2Zqc3pvVkVFa3B1UU1NSW9QbE1SSFhSWGd1OEhGakJ3SkxnZERid01H?=
 =?utf-8?B?S1puTHRBWnB0WnFmNU1FTlUvaUtIK2taQ21lWll1RXRlbjBIeW1QYnE0ZHBK?=
 =?utf-8?B?V2xKT3FuMVlLWGIzUnZIRFFjMTNYVEI5MHNTTlM5SjZSbUNuVWhlTDVPakNM?=
 =?utf-8?B?VFh4L2VVZi8yQkU2WndkYjV2dzNTSWxoQVRaM0tGVHI2WnppaHh0UkxCZ05R?=
 =?utf-8?B?cXQvOEE3anAyMlg5bG9Nb2tDYnY1SHRhK0xha0JKVS9uYkZ4RnVlYXVGWVhv?=
 =?utf-8?B?OFF1U3ZoUE9jRElISkV0MittR0xqQ2h3VEFObkJDRVFNb1V5dUI5NnllT1BF?=
 =?utf-8?B?d2UvNUsvTUVNbWdvK1o4NWY5WWJkWWlBaEduSURaOGdhRm9wTFAxRXgvSzNj?=
 =?utf-8?B?bzlCWldiZjc1OGNxRUN6SmVlUkNkV3dKT3lYY1BtQ1dSczFZZmlIaUFZM1hN?=
 =?utf-8?B?NlE1Nnl1YVIyMlVnTHV0TUhLK3l5TU1hcFlGSHExZWtac0R3OFdHU055SzhD?=
 =?utf-8?Q?nRet+tLqG5/I13dwMRWP2OaUJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5709.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9491be-2e21-4544-df96-08dca8d34275
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2024 15:47:28.6020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6FvBUEi9PhibgAhIpVuTx1oHk7u0a9sN5HARJ/x5zvhi509aCGt8LLGJR7SxdIu8qwEhPZGIZjR2SLEr+iL4IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5477
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_12,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=569 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407200113
X-Proofpoint-ORIG-GUID: kVLaearptkR4I3VnXkGCP2MhFhx2dA9W
X-Proofpoint-GUID: kVLaearptkR4I3VnXkGCP2MhFhx2dA9W
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1015 adultscore=0 mlxlogscore=526 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407200114

SGkgUGV0ZXIsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBhdHRlbnRpb24sIEkganVzdCBsaXN0ZWQg
dGhlIGRldGFpbHMgaGVyZTogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjQvNy8yMC8yMzENCg0K
DQpJbnRlcm5hbCBVc2UgLSBDb25maWRlbnRpYWwNCg==

