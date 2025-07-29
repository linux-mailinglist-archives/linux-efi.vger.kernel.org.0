Return-Path: <linux-efi+bounces-4498-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA3CB1507F
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jul 2025 17:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22681883B71
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jul 2025 15:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD8D293C72;
	Tue, 29 Jul 2025 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qit7eUsc"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD67927C162;
	Tue, 29 Jul 2025 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804355; cv=fail; b=RzFgzGjmURhpRSsUehRuP8Tq9zotUafYd7RcynYA9NtB/07cP1wtvtSm3/vGb4lqDfKf2n3j1R/T1BpAp2rJBP9/yzZkKa1H2beBKY/GS2UjgynbV4jXuizd5RA/M8s4ZFveszFWGAavp8Gq6UTfECcWVOpfltjasg5u610X5FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804355; c=relaxed/simple;
	bh=HKBKlhIrqvmQVV6O+vEDFCqQom1QByqtDQi1VWU8SzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S+WxoNeiX+hM1X3xgimMroLxresNANv/6mgvv5X89BgEkSzzQPQQ1WV3Glq7FYj4Gc29SEhd3wvl5WF1IVqWj4B3py0/Q7xNZ+371ExCGFMrKO0wZugZpV8y4RMW8qdRLDq5qAdJmVhd2+8MtkduZ/laRTxFH9ivBLb5mUeMXaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qit7eUsc; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pl2Dum/cwl6ws0ReFmGFNa6aFRQeKefktERC+/sFTE8zZ9apeHrcpCeya/Uyr0BkRn2gGuPLl9TltwG5L7EJFzQVZlRrc7Q/AFB+/05Jncb3W3Yy0+OFlM/l0kZt7nOfrN94MJ2SekMR/q53UDEI9hoDvSotiR9jOvf69M22cf6RYWnxIcOPXta8KSKXnmG1BhACa/BXD99Y6dwgvGMFOI9pS1qghp0NxkgK7LAML76DANyo8K3FtQewEh14sWb/VyAOe8pmGv0GDJ+Os7ga8Z9ByJpx+67wx+A+py1sYlQAPUXpy7UnVMsGArD55HXTWOVKtu9YgP+dUfH9j4+G9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lYOvMoYvxnMeC5pFQS+pdhgKyeYcpmRmOqVeJZ7OZA=;
 b=rMDeF9aTrMGOo3mlpJ0pPuFMEsV2c/BNyjolr2g9JZcIAVrzkv/5XGf6CQwNv5S2r81SvakS7lk2NmmJj2ur00GtjNdtGawXE/LT1yBvj6Sa6LdaP/RfGXVlM6/6x0sK/0nymDTg48ExQ1mB3L92iU6ZQ5Upnv+U0flzRz7mJMEOYa/b8t87/6CUmH1scyYbNmk9nfT89RZ1+sBesQgZhZu4veC8ybOrlpO5t7qovEPDo7/D9JUWDl/t2cNM1KH9D/MXf06Y7Yk7ylq2feB7EdVaFRIsNCCA6/mNC0HjfQGA8FVO9MmMWnZpgqBsxvd/kmt9nH+loNQ4Ii4Mc8UdSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lYOvMoYvxnMeC5pFQS+pdhgKyeYcpmRmOqVeJZ7OZA=;
 b=qit7eUscIECWVBsdKpffdHZ4mSNSHzMV8BDAw0goTe16xLXAa4jl8nlX9Y6uJFAbPtQwk0gbbxblQh9h/IR9gRuM4KDO+DlkLDfXnoGGIQYJpQY1iVDhPcAS0AYPi/slWNgveFYupc3giAW5ecbGJ+QOJD6FGye0DVhHPn5ie0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by SJ0PR12MB5635.namprd12.prod.outlook.com (2603:10b6:a03:42a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 15:52:30 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 15:52:30 +0000
Message-ID: <5c052302-8639-41ef-9d51-3814f2778674@amd.com>
Date: Tue, 29 Jul 2025 08:52:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: "invalid agent type: 1" in acpi/ghes, cper: Recognize and cache
 CXL Protocol errors
To: Marc Herbert <marc.herbert@linux.intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, tony.luck@intel.com,
 Gregory Price <gourry@gourry.net>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-5-Smita.KoralahalliChannabasappa@amd.com>
 <074f5f77-7bef-4857-97fe-b68ee9b0afaf@linux.intel.com>
 <dfc6cedd-c125-4201-a98b-cbaa84a4f370@amd.com>
 <ef9c9418-2def-484a-89fb-b0235391ad83@linux.intel.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <ef9c9418-2def-484a-89fb-b0235391ad83@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::8) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|SJ0PR12MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 11057d06-de50-41bb-2e22-08ddceb7ec97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXdvT3A4OWdEOE1LbzJvS1ZsTUV5YXplUE9qc2pmMTNIV2FRSjIxV1BzWVZ0?=
 =?utf-8?B?bWN1NlJuc1pzc2lzMWJVY2tvZWh4UFlMcnpwTXd4TExIQXdBRXlvK3NyOWFw?=
 =?utf-8?B?NnFxYVQ0RUZLOWRQVXVIR1E4VEoxc09aK0pMSGErQzRQMTlGV1ZaL3hiMW9v?=
 =?utf-8?B?cll1cHlnL1JRQmZFeHl3ZDJiWmQrREtGZmhjeVJJVDBPb2hwUnZaVWE0V0tL?=
 =?utf-8?B?VVI5eENIa1B3QmYwaHBRelpyQ0RDc0g4cjhBZFNKZjNZbCttcklOck1mN1py?=
 =?utf-8?B?Wmw1eDRyNWtmanR5M1VYTHcwRlRrY0dmYmozbkNNdER1NUZKUVZMVEpyb3g4?=
 =?utf-8?B?SHhJYXB0ckxiUmQvTzBPRWpTc0p3V2N3aDd2YjIxUnJLZ2I1TGVpTWZFQXBV?=
 =?utf-8?B?UzE0Q1oyUGRFVFZWRGNoSzRLc05EMHJlbWIzQXlwdXcrUTRlNEpWL3dRU0Yr?=
 =?utf-8?B?czFNWG5rUVpRWUdVQUpxMXdocUhrTTIyTXZzV1pIeEk2UHFtZjdocC9MSDdi?=
 =?utf-8?B?K2U4MXB2MjJERElsTmhnaXI5QjhWR3QwWlFjSXFpYUZ1cWZXRE5ESjhVckNy?=
 =?utf-8?B?RWR3S2xkL3MzNXdBRkQ3aGJadDdEazFJb3ZMTFZGZjF0aW9ZRS91SnAyTWo1?=
 =?utf-8?B?T2kyS0llN3BINEQvdFE3K2tzcXNqejlQZWc0SE95RExjallkenBtN3NlU2V3?=
 =?utf-8?B?WXdqU3pxS1VBUlZYQzVpV1ZxNFR3Qll6ZWM2V05zajJwemV5SUx6Ymxxc1hN?=
 =?utf-8?B?dUl1QTBVd3A4dFdLM2F1bmxwRXhxT1pmZ0tpWi93MTlRTVZZV2t2dVhoVHps?=
 =?utf-8?B?SkZETnhZOS92SzM3c0dlWG1VMVpmYVc3UzhYUnBaVWE3cC82SXFVZi95M09K?=
 =?utf-8?B?QVJRckxPK0tQQWxhVHorVzFKT0l5N1ZwUWg2MkNVblk0T1JJVGloYUFoV3o2?=
 =?utf-8?B?Z1J1S1RhczdWSHBHdjh2SnBKdnJrZmZnZWEzbTlvR0FkMTgvZnFiOUJSUU91?=
 =?utf-8?B?NTUrdlBqaDlYMXNCRUlabjB2ZXd3ZXRtOG5GR0REeVdsSnhEV3dTWmpkc3lI?=
 =?utf-8?B?b204ZHVDL2lmdVd0amtWTUs0Z2c4VGdMNm1hWm8xVFlqZGJKckdXaHRGZVJm?=
 =?utf-8?B?T3RBU1FGTE5VSXJFNTJrSDg4TTcrR0dtLzd6eXFkTWc2UEdvUFM5SWZneGhw?=
 =?utf-8?B?ZnBiQUd6eG9Va3N2T0FuSlMxYXR3U0czOWJFOFVlbldMMEFWd2R2NVJmYk1K?=
 =?utf-8?B?NGNoemR6Nk05eGpDTWI4dXFpRTEvSExERTVZQ1hsY0VVK1VocmVIQnBUek1Y?=
 =?utf-8?B?THhCWGxoMk0rLzZLeStIQXFUdE9VemdjSkN1eisvcEFKaFVPV205YWM4Vit4?=
 =?utf-8?B?VUxmVXpDR1V4Z2dDUXFYNXlXZXZ4N1Zad0t6UWRJVTVubkg1aTZ0a2dTN2hp?=
 =?utf-8?B?VjUySG9LamhEZ1hyeVYwcHpuN1BBNFlXYjI5eXcvSkVNMG9Yb3Zpa3ZRcExo?=
 =?utf-8?B?T05MYmNFdFF2QUZZR1Biam5mMUxpODdnWFdzc3NMOXljcUdWdW84Szh3QUps?=
 =?utf-8?B?elovWjFsRFg4NnZCdUdVNGZ0cFdKdmZ4U0FOaDgrazZ0UTFaNXNqL05DaXZR?=
 =?utf-8?B?WS9kVU14aUpwN2dWUWcvcTJYUno0eWpRNnhIa1BCYzc4YWJvUmVtY3JzZWtt?=
 =?utf-8?B?MzhXSFR4THBCN0RtWFFQK1o4RXVSSlgzcFhTVnFuZWFENFN5d1dDZVBHeDBk?=
 =?utf-8?B?SC9EOGs2eU9GN3laOFZ0Q1BoZEYvWGxsU00wbnhMWXNMYWFHLzJKZGhXeHIx?=
 =?utf-8?B?NjVINER1Zkxmc3REM0QwdXNjNXg4WmFqaE44UWVYM2ZGTU1sdmtLRFppVXNB?=
 =?utf-8?B?MEJaZzVRajJ0NkdxL3RlTjQ0VVF3OXVvV1p3UE80Nm1pWmJTQXZtYmYwaW50?=
 =?utf-8?Q?5vBoLfBNDW8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkdnZXhXWUtLMW13cWdNeFlTSVMwOFJUVnB1RUtTdDNrNHF2YnNjK3VjejI2?=
 =?utf-8?B?MEdlQ2RSYjZ3RFV4UUVRWFozY1B3MHc2Q1dBUktZUFdKZmhRNXVTVWpUUVQ1?=
 =?utf-8?B?WEpKS25Yc0RzcG4zdnRKQW5yZXllQ1pHTi9UOGRUUUxBQ2xsa212cm9kMFZ3?=
 =?utf-8?B?RStNYVduRWdkbXQxVnc3dXF5VDZxK2xSMzYzT04zZDBQTHk2Nm51eEN3R0Jo?=
 =?utf-8?B?RisyYU9Tdjc4dTc1Unk0NHhwQjlHSXNSQ1ZrdnVMU0ZKQXlFYnkvaTBiNi9l?=
 =?utf-8?B?dElnSVRnM3F4L0Z0ZWxhSldNeC9zVGtGVWxVMDVCTU5sNTFYWlc3eFd3U09O?=
 =?utf-8?B?ZjVZVnovSUtCaTkvYUxZT0hZWnJjN3ZBK2dDRTFRa1lLazQ3M1FGVVhOK21x?=
 =?utf-8?B?Qm1yczNjOEVjSlMvdDVmRlRqazIwRlorekhBVG5NUjlUK21kM3F3d3ZicklL?=
 =?utf-8?B?MjZkSU1wQmlIWFoxbUt4VFMvdWxZbFFOT0ZaVkp4MlZSRW5TVE5HUXg2VHU3?=
 =?utf-8?B?QXZ4bUl1RUVuOU4vcjdteDJUZ3p4OW82M2R2SCtrYjhNakpYbGU2RUllbjhQ?=
 =?utf-8?B?WXF2T2JUcFhvNnNBUUNNQW5NenlEb3dRK01sdTJxRm1MMmVaeXhtWVd1R0dI?=
 =?utf-8?B?SmZJRk1FUHVIbzdWNFRvZWZYZzZmZjJoN3FUMkdtbTA5MUJkb3JmTHVDeUNN?=
 =?utf-8?B?dnkrU2pSR0xidHZyckVnLzNGSmViWUluWkgwa2tBdWovK2thYzN2R2NPb0Zv?=
 =?utf-8?B?aDFIM0I3b0REMTkzYlJKU0JNc1NyT0dBc0k0Zkp0RC9tb0Z2S1JRQmlFRWV5?=
 =?utf-8?B?K2g3RmNUamhXQVhERS9WbTFaVE5pZlJXUnpjV1NZeDhBb0ZhRUw0T3JiRGxu?=
 =?utf-8?B?ZFJpczlxUkZZeEY5VkN0VHhnQ0dMalRuZFVjY1R2TmdDQy93eFVQOU9YQ2hl?=
 =?utf-8?B?SWcvSCtTMWV2eXQrdlo4ZWtyV0tSVXZvN3NIdFFXZm1iZE1XYTBpVGJtKzZN?=
 =?utf-8?B?ampwN2Z3ZHFNUkhtbGhoVHk2TXZMNHNPR080bXRibktYUmlKWnRBOFBMdEdX?=
 =?utf-8?B?TlZ0NDY5aDBIc093ZktuNWNTR1JhU2kyTVdqUGZ2VjREVWtyTG5hSlhwNGtP?=
 =?utf-8?B?bC9lZ1pQVlhBWkhLcEpvZTFMMzVWblhOUisvQ1EvT0Z4dTg5bE9JcnAydTJD?=
 =?utf-8?B?eDV2U25kUTU1ZTFnaWlaK2c0cUpYZGViV3JONWlNb25ubVBsQTlhdGRmMFNh?=
 =?utf-8?B?MU00YW1DOGRaRDhJbmNTWXFFd1RuOHVaVTBIeHpDSUppNUQ2Q1FoSVg2VGZT?=
 =?utf-8?B?YVBkQ2pLSDVXQngrV0tUTFdQYVVmeTZkOFhZM0VHemJqRXR0NTNIaEdNMkJK?=
 =?utf-8?B?dHNXRHhCSTV5MXdlWlIvdXY1Mi8vRll6VklvRlJBeHMxQlFRd3JkNnVmekdO?=
 =?utf-8?B?VFlqSHpVSjM1MWJzb0J6c0R5RUFZSlQ3ZTJyYUhyS1A0ck9kMUlJNi9lWStS?=
 =?utf-8?B?Y04xRVBlOFZnYUhFNlVUa1I0QldLektJMUV4K2RqNGRvRDNHNk5EWGkzQk9o?=
 =?utf-8?B?U0x6VDQ5OS96eC83Zm5BTzMxaFB2V0VRNmVaSGE3M3VTMTZVcVVDV1huTDhk?=
 =?utf-8?B?OWN6YkVqM1lPSGNuN3hXV3F0NmpvSzAyblFRYW54TG5jQ3o4ZHZqUUJEQXh3?=
 =?utf-8?B?eGt3TldLTGxkSGFhYW9ERFlESGp0dGlpcUlkY2pMMVZiYzZYdEJYekdTcC9F?=
 =?utf-8?B?MU5naE5KRDNCOVliLzluVXVleXpoSlZ0VTZ3OGNGL3Y5aVFBQXlVL0kvUGEw?=
 =?utf-8?B?aTY3K1I1d1JRdDRqaE84T1NrK2ZLL2x6Y0tkR1dScVZHcVpXL3pXZFRVK1Y4?=
 =?utf-8?B?RjBnaVpaV2lFTmxtNFRmZ2hQQ1lESmgzd0haZWJaV0o5MTEvMytwSS93LzA0?=
 =?utf-8?B?Rm5OdVRBaWx1Z0xUbTRoSVpYcXE3aHM4Z0hMZnBqUzlndFVyN2FXcXNQWklK?=
 =?utf-8?B?TlAvWWhUK2kzanAwZnlobnRjaVZ5ZGE1UVZIQ2VDTktGNmt0TDRieG92QUp4?=
 =?utf-8?B?bXFES0VSbFJUTEJ3SDduQWc3OXJYcDBJVmcwQjJjb0drMTBhT3MwWjFkL04y?=
 =?utf-8?Q?iE5+S5hy/mq/ASQChH1KIHo+7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11057d06-de50-41bb-2e22-08ddceb7ec97
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 15:52:30.3736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRFtk/K2eHMz/RR2bBqLs3O1FYNj70vXok2S+1eFkgf09rOhYCCMCGhmgnTBVPRxFfaa+zMkrkW8E5ueUpPh2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635

On 7/28/2025 10:41 PM, Marc Herbert wrote:
> On 2025-07-28 09:25, Koralahalli Channabasappa, Smita wrote:
> 
>> On 7/22/2025 12:24 PM, Marc Herbert wrote:
> 
>>>     The code below triggers the error "invalid agent type: 1" in Intel
>>> validation (internal issue 15018133056)
>>>
>>> It's not clear to anyone we asked why you did not include RCH_DP in
>>> the `switch (prot_err->agent_type)` in cxl_cper_post_prot_err() below.
>>>
>>> I can see how RCH_DP is special in cxl_cper_PRINT_prot_err() and I can
>>> even understand (despite my near-zero CPER knowledge) some of the
>>> special cases there. But in cxl_cper_post_prot_err() here, it's not
>>> clear why RCH_DP would be rejected. Could this be an oversight? If not,
>>> a comment with a short explanation would not hurt.
>>>
>>
>> You're right. RCH_DP was excluded because it doesn’t report a valid
>> SBDF in the CPER record. Instead, it provides only the RCRB base
>> address.
>>
>> I haven't thoroughly investigated whether SBDF can be reliably derived
>> from the RCRB base. There might be a platform-specific mechanism for
>> that, but at the time, it seemed non-trivial to implement. Introducing
>> additional infrastructure solely to support RCH_DP felt like it was
>> adding more complexity.
>>
>> I agree that a brief comment explaining this rationale would help. I'm
>> okay if you plan to include a fixup for this along with the one for
>> the device serial number.
> 
> If I understood you correctly, I think a different error message
> would be much better than a comment. Like this?

Yeah looks good to me. Thanks for fixing this!

Thanks
Smita

> 
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -730,6 +730,9 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>   		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
>   		wd.severity = cper_severity_to_aer(severity);
>   		break;
> +	case RCH_DP:
> +		pr_err_ratelimited("CXL CPER agent type unsupported: RCH_DP\n");
> +		return;
>   	default:
>   		pr_err_ratelimited("CXL CPER invalid agent type: %d\n",
>   				   prot_err->agent_type);


