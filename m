Return-Path: <linux-efi+bounces-1477-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2C593A29B
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jul 2024 16:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E421F233D9
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jul 2024 14:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B3015380B;
	Tue, 23 Jul 2024 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="juddabsl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D59152534;
	Tue, 23 Jul 2024 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744544; cv=fail; b=OFP5EB9pPVlJ5ED00eA1tFoCz29+jRWcC+T/2vED7q2pIPgYrMrDE5MFa2/kQLxzPwH4bUKTfbqzVNSdhqknoc+sPuypMZtTBrS8UBy3fKKPxuMtfdf0jQz1/ngK/zGbIIZ7wXQCVncBLjZKUpuh/IpkOzo/IVBlpmEBgViJwUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744544; c=relaxed/simple;
	bh=vondd/SiHMqZs7KQzsVqcV1Tc1HHn3ntpr7RaTRHxPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wc39tXjq5sN6okrfCKP7mzNEz6cBSefWScr+B8pGtbKZ7GM8Hhazg58EI5CQy6UrzqpnaV9bH0S8IeXuP6aw/rk7joKAutSUevonh36ZtuX1gaNfE3nDpk6I8KiuoyB/kGGf3I3lEoubZWY5I0QBP0WZoFUJsB8aWutd8KRg/KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=juddabsl; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N9Y76N016606;
	Tue, 23 Jul 2024 10:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	smtpout1; bh=vondd/SiHMqZs7KQzsVqcV1Tc1HHn3ntpr7RaTRHxPk=; b=jud
	dabslMLMXAI/hsm2WJeYjXuY5x5/6EobYOUt290wRgq5SdRmh7l1ojKfZrga4ERC
	giqTxhHavkcraHPCqNmCc+nDFbekuvtWeaQPcIcN3/ZuyZ6NPNKiwL8lssOyRGTZ
	fh1nhIXzIqWh5WpQkJHMG3k8gFoRppJPzhzAA/aQgQE4nng/wlsQnEvTyJ0nWWQT
	RBO+1AcHSpy+woGtYc41GtEM0y6Osafq2Y09VimxQgVPveiXsNfXFLnkGn9OqzIP
	6ZX12gwBePAmBOKsVWhHZpnBW74hKypB7JvC69zbVkr3yNawJH9v+3CL6cpPc0O6
	Px65AOdfpQNIhzp82bQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 40g8da4ush-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 10:21:37 -0400 (EDT)
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 46NDjxtg017955;
	Tue, 23 Jul 2024 10:21:37 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 40jdpghmfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 10:21:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFhxqE2SajAwyphDy64LnCa87kOqvZRN/ZvH7NSo4sSx8ls2QIPkuhS3s4qSn2mok/uNXVDH8sc5EPHpG/HKusE3wV58HGbfL3b8WCNxhtnEpqIuVA5SOB3fWh+TdD3vTfeGNvU/xxoicfma0B13D/ctHuFWtmhXHGkCmiY68Ehcz3zCF/VgovNdpn2S1AA9fWAqgUiViBA92w3NpsTxQfiOEM8evxSVZVIGM81RHjI90kCXcBnsThNUFrdE1RATnU3Z16Ee6iPl3Afa8pF6/W5gGnF3CC4qO/BD8ErhRG4VbHAuGTkqwL3an1YQ14zvqu7Z9UixeGRXPUUi9wJnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vondd/SiHMqZs7KQzsVqcV1Tc1HHn3ntpr7RaTRHxPk=;
 b=okE3OZX9SW6a0TvQ08VFM3FzW9lCFFaX5F/Mg2De+v/RRI0MF08bx0B0ttM58Ew0lFyZItqZ/jbA8Rs/NvgL/0nZyi8ERYeJ8kM3GpM3Io0hA0v+j/N0Up7QS0+0UP40yi8ep3GAzx6pkKSYMPX30tSfiXcXnl7QeL6xUUl4vMR3wjIv5QjuMPeBAC0PEfjsGGhQJn/fhPXri0YeQ5bctVj4ij9uqocNRwqZo3DZbpZVwsfXmD1Wg5F75kiR8G10d6nWTTZWDlAgrVj4nJ/yp98XrBOYDlemIOtnTGYaEFtDG54esHYirlqRv2sEyaRW2lZVWZLaZ9Z5cTcQ0QNI4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DS7PR19MB5709.namprd19.prod.outlook.com (2603:10b6:8:70::15) by
 DS0PR19MB6550.namprd19.prod.outlook.com (2603:10b6:8:c4::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Tue, 23 Jul 2024 14:21:31 +0000
Received: from DS7PR19MB5709.namprd19.prod.outlook.com
 ([fe80::3d06:d879:7717:36e0]) by DS7PR19MB5709.namprd19.prod.outlook.com
 ([fe80::3d06:d879:7717:36e0%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 14:21:31 +0000
From: "Shao, Marshall" <Marshall.Shao@Dell.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de"
	<tglx@linutronix.de>,
        "Mishra, Ashish" <Ashish.Mishra4@dell.com>,
        "Chia, Jia
 Yuan" <JiaYuan.Chia@dell.com>,
        "Dion, Christopher"
	<Christopher.Dion@dell.com>,
        "Caisse, Joe" <Joe.Caisse@dell.com>,
        "Mukundan,
 Govind" <Govind.Mukundan@dell.com>
Subject: RE: [Patch] Do not clear BSS region in x86 stub
Thread-Topic: [Patch] Do not clear BSS region in x86 stub
Thread-Index:
 AdrYGyaFCseU4QE3SCibBf0Ev6R9+wAQOiGAAABrtYAAlzZgQAAtv+GAAC61pjAAFgXwgAAb9bQQ
Date: Tue, 23 Jul 2024 14:21:31 +0000
Message-ID:
 <DS7PR19MB57092B4012BEFBBA52E2C2748BA92@DS7PR19MB5709.namprd19.prod.outlook.com>
References:
 <DS7PR19MB570996A580C6F5D2C9CACCE48BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
 <DS7PR19MB5709B2A263E769B461091B0D8BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
 <CAMj1kXHBSNxrzbQoaDea7HFcjN9HHk5==tXg1WLHDzW61aj4cg@mail.gmail.com>
 <DS7PR19MB5709B39C90153DAA27DA122D8BAE2@DS7PR19MB5709.namprd19.prod.outlook.com>
 <CAMj1kXHS0rr9DfKCeD-Zz7y1Bk-3ncn2cEgVmnWE0Jq1B=+Acg@mail.gmail.com>
 <DS7PR19MB570924EC5BB1BA3F321A65B98BA82@DS7PR19MB5709.namprd19.prod.outlook.com>
 <CAMj1kXFjWBpOij5V3=-9etqTW9p8guqPDCGU3DK0Yxq6zrBiBQ@mail.gmail.com>
In-Reply-To:
 <CAMj1kXFjWBpOij5V3=-9etqTW9p8guqPDCGU3DK0Yxq6zrBiBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=c16f10f6-d132-4c08-81f5-8eb2e6ca62bf;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public
 No Visual
 Label;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2024-07-23T11:35:11Z;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5709:EE_|DS0PR19MB6550:EE_
x-ms-office365-filtering-correlation-id: d845b62c-9506-45a7-34b3-08dcab22bfe4
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yzlzd2FmVmd0T1JLeGpsKzRIN3pHVEZSblMvU2REYy9mSWlqSVAzTkY0Rzls?=
 =?utf-8?B?TVl0TW4rWmh2cVcvVG1DNDdNWGRScndhTk9aZUFxYW1DUUMwR2sxRDN1QlAw?=
 =?utf-8?B?ZnJNWmRqTkxaV2IxTEhncjR6M0pzZnVob240SGlDekNtRStudS9nZFJvRllo?=
 =?utf-8?B?OU5nUWhNUmRpYnNUdm5mc1FBcU4vRFIvOXZqWWpiSDNjWDNSZmEvbEIveEl4?=
 =?utf-8?B?WEsyckNLNEZRS2JJTlg3QVdibStVdjB0UGlIWUlyaGpnUC9TWHF1SEFWelF5?=
 =?utf-8?B?ak1vVE0rUzN5R1EyK2hGQUNCd2JLM2grcjZSa3g5SUpXakRTSG44SXVNa3NT?=
 =?utf-8?B?M2RsaTNtdHUveTFZNUtzT3lYUUliYlZxS1FBbzJPTHZoQTltMHVFdkJoVU1y?=
 =?utf-8?B?UW5EbjNlV2tCdEhoT3RvS0Vqc0pHdEFqN2t5dlFGRHFRUlFUdU1zTTBteEV5?=
 =?utf-8?B?enI4ZWErVDVyRnhZZksvTUoxSEdseWt2VlRrZ1lUMFBnRmFGNzRNYkI3L1NC?=
 =?utf-8?B?dUpLK0dqNEgxVU53RnBQRHpvU1VlRkZFb1R1THJJc1dpMDJlbExwN29UeG82?=
 =?utf-8?B?NzVTa2hlMmI4bjZpVGIxNWFZSXU3VzRRNGtMN1FHVm9qV1Nod0drYi9OblZw?=
 =?utf-8?B?c0lEUkY3dVo0d1V3aE5vS2taUTZsV2xyclNzTjk3aVpQQU5QODJXUVJobVhI?=
 =?utf-8?B?NGVBWnFYNW1KOUZUbm9JVkdDaVVVNTROL25wK1FvR3RtZHJxZmxodml6ZzhD?=
 =?utf-8?B?UHRxMFByK0EzVHdBbHdrTnRuQTcxcFJmRHJ5SHdFN0xIYkNTaEVHR3dBV3Nj?=
 =?utf-8?B?L1dZZnZxVmQvSGhoSVpKZjVSc28zU0crM3RHRTFiaXpIekF1V2RZcS82VWQy?=
 =?utf-8?B?RHJ4STQ3TDNjVmpNZGlXSTY5djl6MUJWY3ZIRUhKQmFSanlyTFpKU3hqTGF1?=
 =?utf-8?B?WUJqUEV0eFdXdWhhRWt5b2RDalpuYXowSUpOd254aG5FVk9JMzdmT3lkVW1x?=
 =?utf-8?B?M1lLVnJYcVgwdldlejZMeTNEL2ZHaDBKK1RkbXRiNEJzZitwcDFkb0pybC9D?=
 =?utf-8?B?YzF4alM1OVRRU1pKUlA0T3BYS1k4WHkzNmxZTTVhT1NFRVpxQkprQUZKdkZi?=
 =?utf-8?B?TTk3TjdScm0ydk44cGpNMWxEdWJDOTZ0WTVsSDVFWkNnMEhZWTJYTmtrYWZy?=
 =?utf-8?B?ODkxdDhCeHNkM0xQN1VINGJsWmJqbGlDUmlUQ3RoNDdIN1U0dDlYSGFCUkh2?=
 =?utf-8?B?MmNqZ0JqSUpucEdaL2pORkYrRG00UTdKaHlxKzNnWGpGQ2lmR1ZoOTBnRG0w?=
 =?utf-8?B?eUJMYkxSVi94WVJmdzI1V0gydDRUaDIwMzJPbWI4bVFEd25LVkYxcE95ZjVG?=
 =?utf-8?B?bkhPbVRQYXVPTnRSMEc4MEFDYUJ4c29WRjk2UHY0VzQ3NnFmaUZ5eGtkeXVS?=
 =?utf-8?B?RVFtUjlzaHBqZGhoZ0kva21vK1FmQncyWHNnTGRvbnJRSWlxMCtzeDRSUlpI?=
 =?utf-8?B?T2tSUjhqRURZLzFFQW1hSUpiVnZPQXRTdisrWTlsNjNmMjlabU1OSGk2TW55?=
 =?utf-8?B?RWdsbDhsQmFGR3lUWU5Mb0RYcnM1dUFDSVFxbWsweVJseWJEMTlDb3h2U0N0?=
 =?utf-8?B?YVpaQUhMNUFoVHBzcE9lYnh3STkzMDRqUUpkQ2tSaTkrVDBCWmk5ZStZcjdj?=
 =?utf-8?B?NlJUQXE3aURVdEJRbzYwVklWeW1oK2wvUnJIc3RMcytPM0V0NUdTZ09xaGZ3?=
 =?utf-8?B?eTEwMXFqTFlYZnpRN0thYmRlVmxYa2R2bGNPYzBkRlg3S1RjWEF1aU0xZDZE?=
 =?utf-8?B?R0pVcGwxdGJYaVZxV29kSDdpT1llYjUxekltT3kzLzkvQi8zendqL240Sklh?=
 =?utf-8?B?TXdTSWQ2eDJlOFJvU0NWV0V3alRGUEJVVXVudlhlSHlqWnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5709.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWFYK0IxUU9HZ2tUaW1VWVhtS3BTSUluYlZFR1N3MlMzblh3S2NxLytaOHlE?=
 =?utf-8?B?YmpKOTZUU212aEFyOER5RHB5MGFlN3p3ejdNZER6cUljQUJYT3NGN01zSUlG?=
 =?utf-8?B?MTU1MUJZL3UxMHNHdmttTWR2cERIT2svRVBYWjQ4R01Oank1Yk4zYVVNNno3?=
 =?utf-8?B?K0FURTBnRkl0M3ZRSUlPQjZvYzVEL0psTGJmbEFvbmtjd293N3IvdC9CRDY5?=
 =?utf-8?B?SHNXT3dmQkZsamdsaExseVZpWGg1R2sxQTl1Q2V3MGFMTWl6M2pVN051NUxX?=
 =?utf-8?B?WEFtSDNwa3poQ2xoRHJqWU8rdkRuQU5hRGo5Zkk1ZkxBN1RsU25XV2J0YXBh?=
 =?utf-8?B?bk1ZU05ic0RyaG9zOExsTjArWVAvUEJhNmNTM29acUZNVzZDcmVXbjJNZGtq?=
 =?utf-8?B?RENxMXlYRTAvRERXTGR6WFpmUm5QcEhZOWFDWlJYSDFiaDJUMmxTbzBlOWlG?=
 =?utf-8?B?U3JRR0MyTjlZVzc1cGdsNVJ0WXZNVm9EcGg3Uyt6WVlMcEN6emtGcFZEUnFq?=
 =?utf-8?B?Qm43eDdwNU12WFRNTUdwbHRKdlo0SDY1UG5xZTJZQXFKMEN5ZythNGorVWMr?=
 =?utf-8?B?WklxekdrNm5ybGpoMjhSbDhPOGovM01iRWkrSHphRms5eWE2MUhEVENibnlS?=
 =?utf-8?B?eW5jTDR1SktFM09MdThFU3VBd3U2c2hlejlqUTRJelpqU3BubGN6NUljbk9t?=
 =?utf-8?B?aTFRTTdMYkluREJrV2hWSW9DY01TV0dERGRlK3czR2V6M09wcTZGeHBPaFRm?=
 =?utf-8?B?QmtpVUg2ck1rUVRueDBBUnZ6T0Y4Mm8wWlpVU0ZqWGIvTkFvbTlleXR3cFVr?=
 =?utf-8?B?NjQrTUxkQVBtUTJlTGNoRzRtbjlnbHJ1dEJQclZ4M2hqUkFMVERyMS93THhT?=
 =?utf-8?B?Q0dkTzcraGxzaUs5K3RYZmV2bnZVUTl1RmRXY2tsdVc1VHFFUEEybFY0c3du?=
 =?utf-8?B?UEdCN3lObHRjRVJMdDVCYTd6R2tLNWh6R3FWN3JxNTZ2K2tHZDZ5dVN2MzBH?=
 =?utf-8?B?Q29yV2dseS9NQzFWWU9NcUVDRDlxalBNZlBvcUFOL2cvZnZFYWdpQ0lQSjRx?=
 =?utf-8?B?Z0wyVXQxQUJMWStvamI5aDZEVnlhRVdFeU1mSlU5ZWJFQUlOQUdKa0RCN2Mx?=
 =?utf-8?B?S3hvVitlcGtPWVV6WnFIVWt4TGZzYUhxK3lCM0JkZUc1SGhJQWRHMFlvTnBj?=
 =?utf-8?B?NkN0ZE1Zd0wzdHpqM2paNk5mVWNQUStTR2tIK0FLYVNHWUV2V0ZMV0pNZTBp?=
 =?utf-8?B?ZFd3S05EdHVBVFUwalI3RG8xY2FvQ1FjeDZZUkRKME83WW0wRnIwc2p5MXpF?=
 =?utf-8?B?Rnd4WDNBK2JybTc1eGFsY2lXbUFkRjZBWlRoVStxcWlvQ093MUU2WFRXTTda?=
 =?utf-8?B?TjZTRFZZT1V3YjZ5MVZudU9oMFdJVzdFeFZ5MlJTUm5ObkJaTlpKMzJBdms5?=
 =?utf-8?B?SUg2N0MzOEdUcFlsOG40ZDFTeEErOFFKZzZ4Y1BpWXNOQlRINFBwVjN5VzhE?=
 =?utf-8?B?djY2UnBDVW9NditwOWVvOWxad0p0TUZJZ3lTdW8zb2tXbDNITzJVWkpBaUYy?=
 =?utf-8?B?NU5QSWhRbFp0cThRUEtFRTgvWFZXVHYrNGFua3RGbGxBbFp3VEZKTGZnNG9i?=
 =?utf-8?B?U2JkeG5LbUlWOUxNUkRYWEp0bUFwQ3hOUUVoUjM2UXY4ck9KQ3J4NzdQMmxM?=
 =?utf-8?B?MGlSdXYrcjY4ay9FQW5wTUt0a1MweU9YSE81VXNqOFFtT3JkTUh1WHJDNGZi?=
 =?utf-8?B?NFVEeStsOVFoV3VyTDNvL0U5aHFuKzN1dmFDeWtUK3RPUzRhK0U2YWhBdFlO?=
 =?utf-8?B?anB3TUxMdjBmTDRnODFVdGVuN3ZXUktzMEUrb2lHZ0Z5T0ZsWWFPdWx6MHZq?=
 =?utf-8?B?OEVyYklNSDZZbGErZTc1N3hlRTRRS2hBYVdUQ2JvMkR5K2hEajZ5eVBLTGYx?=
 =?utf-8?B?c0Evc1pLcHUxVHg3ankzeUZxL1Z6YUtIbk5XSDRRYlRtdG1MY3JBQlduQk11?=
 =?utf-8?B?TUhreG91Q0hPTmkxaHR5YklPYkJMTVVtU004c2JXSjJleGgzdXQ3WVVUMHlL?=
 =?utf-8?B?TXFNTCt5eHdrVlkvUisrZjNsRE1PNjh6VVZlaEMzcS9sVXFjOUtxQVVnK3Ez?=
 =?utf-8?Q?ORAL8iz4vArOD1hgqnkEdMY7A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d845b62c-9506-45a7-34b3-08dcab22bfe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 14:21:31.5840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ms8QHTTFzaA6NAUOJLLk2Zi+GhsK3Wg81Mmrpcw70OSJ3EK5+NDkT3MLtiBz4/tyT4RrHqz1QLu2QyoZb6mb1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB6550
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_03,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407230102
X-Proofpoint-GUID: fnHxaGQR81Jd7lPYTWnWGOJF-SMxzwl2
X-Proofpoint-ORIG-GUID: fnHxaGQR81Jd7lPYTWnWGOJF-SMxzwl2
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407230102

SGkgQXJkLA0KDQpNYW55IHRoYW5rcyBmb3IgeW91ciByZXBseS4NCg0KPiBzeXN0ZW1kLWJvb3Qg
ZG9lcyBub3QgdXNlIHRoZSBFRkkgaGFuZG92ZXIgcHJvdG9jb2wuIFBsZWFzZSB0cnkgdG8NCj4g
ZGV0ZXJtaW5lIHdoZXJlIHRoaXMgY29uZnVzaW9uIGNvbWVzIGZyb206IGFyZSB5b3UgdXNpbmcg
YSBVS0kgaW1hZ2UNCj4gcGVyaGFwcz8NCg0KSSBjYW4gY29uZmlybSB0aGF0IGJvdGggc3lzdGVt
ZC1ib290IGFuZCBzdHViIHdpbGwgYmUgdXNlZCwgYW5kIHlvdSANCmFyZSBjb3JyZWN0IGFib3V0
IHRoZSBzdHViIHBhcnQsIGJlY2F1c2UgY3VycmVudGx5LCB0aGUgc3R1YiB3aWxsIGxlYWQgDQp0
aGUgc3lzdGVtIHRvIGhhbmRvdmVyIHByb3RvY29sIGFuZCB0cmlnZ2VyIHRoZSBwcm9ibGVtLg0K
DQo+IEkgYW0gdHJ5aW5nIHRvIHVuZGVyc3RhbmQgKndoeSogdGhpcyBwYXJ0aWN1bGFyIGNoYW5n
ZSB3b3JrcyBhcm91bmQNCj4gdGhlIGlzc3VlLiBQbGVhc2UgZWxhYm9yYXRlLg0KDQpXaGVuIEkg
cmVtb3ZlZCB0aGUgbWVtc2V0LCBhbmQgYm9vdGVkIHRvIGVmaV9kZWNvbXByZXNzX2tlcm5lbCwg
dGhlDQpib290IHNlcnZpY2UgY3Jhc2hlZCwgYW5kIGl0IGluZGljYXRlZCB0aGF0IHRoZSBtZW1v
cnkgcmVnaW9uIGZyb20gX2Jzcw0KdG8gdGhlIGVuZCBvZiBib290X2hlYXAgY2Fubm90IGJlIG92
ZXJ3cml0dGVuLiBVcG9uIGluc3BlY3RpbmcgdGhlIGRhdGEgDQppbiB0aGUgQlNTIHJlZ2lvbiBm
b3VuZCBvbmUgdGhpbmcgaXMgdGhhdCB0aGUgX2JzcyBhZGRyZXNzIGlzIG5vdCBmaXhlZCBvbiAN
CmVhY2ggYm9vdCAod2hlbiB0aGUgTU9SIGJpdCBpcyBzZXQgdG8gMSksIGFuZCBpdCBjaGFuZ2Vz
IHJhbmRvbWx5LiANCg0KRm9yIGV4YW1wbGUsIGluIG5vcm1hbCBib290IHRoZSBfYnNzIGFkZHJl
c3MgaXMgMHhmZmVlMDAwMCwgaWYgSSBzZXQgTU9SIA0KdG8gMSwgdGhlbiB0aGUgYWRkcmVzcyBz
aGlmdHMgdG8gMHhmZjk5MDAwMCBvciAweGZmOTkxMDAwIG9yDQogMHhmZjk5MzAwMC4gSSBjYW5u
b3QgcHJlZGljdCB3aGljaCB3aWxsIGJlIHRoZSBzdGFydGluZyBhZGRyZXNzIGZvciB0aGUgDQpu
ZXh0IGJvb3QuDQoNClNpbmNlIHRoZSBlbnRpcmUgQlNTIHJlZ2lvbiB3YXMgbm90IGNsZWFuZWQs
IGFuZCBpdCBjb250YWlucyB6ZXJvcyBhbmQgDQpvdGhlciBkYXRhLCBzbyBJIHRyaWVkIHRvIGlu
Y3JlYXNlIHRoZSBib290X3N0YWNrIHNpemUgYnkgMHgzMDAwIHRvIA0KY292ZXIgdGhlICdmcmFn
aWxlJyBwYXJ0LiANCg0KPiBNeSBwcmVsaW1pbmFyeSBjb25jbHVzaW9uIGhlcmUgaXMgdGhhdCB5
b3VyIGltcGxlbWVudGF0aW9uIG9mIHRoZSBFRkkNCj4gaGFuZG92ZXIgcHJvdG9jb2wgKHdoaWNo
IEkgZmFpbCB0byB1bmRlcnN0YW5kIHdoZXJlIGl0IGNvbWVzIGZyb20pIGlzDQo+IG5vdCBhbGxv
Y2F0aW5nIGVub3VnaCBtZW1vcnkuIFRoaXMgc2hvdWxkIGJlIGZpeGVkIG9uIHRoZSBib290bG9h
ZGVyDQo+IHNpZGUsIGFzIG5vdCBjbGVhcmluZyB0aGUgQlNTIGRvZXMgbm90IHByZXZlbnQgdGhp
cyBtZW1vcnkgZnJvbSBiZWluZw0KPiBjb3JydXB0ZWQuDQoNCkkgdW5kZXJzdGFuZCB0aGF0IHRo
ZSBoYW5kb3ZlciBwcm90b2NvbCBpcyBuZWFyaW5nIHRoZSBlbmQgb2YgaXRzIHN1cHBvcnQgDQph
bmQgaXQgc2VlbXMgSSBhbSBvbmx5IG9uZSBleHBlcmllbmNpbmcgdGhlIGlzc3VlLiBIb3dldmVy
LA0KZnJvbSB0aGUgcGVyc3BlY3RpdmUgb2YgYmFja3dhcmQgY29tcGF0aWJpbGl0eSwgSSB0aGlu
ayB0aGlzIHBhdGNoIG1heWJlIA0KdXNlZnVsLg0KDQo=

