Return-Path: <linux-efi+bounces-3073-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF64A6E325
	for <lists+linux-efi@lfdr.de>; Mon, 24 Mar 2025 20:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4533ABCBA
	for <lists+linux-efi@lfdr.de>; Mon, 24 Mar 2025 19:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF5C267383;
	Mon, 24 Mar 2025 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZFkqoGvd"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C970263C6D
	for <linux-efi@vger.kernel.org>; Mon, 24 Mar 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843697; cv=fail; b=McAnuWdY3GhOjy0rqMt9dGiIOVz1zPDxtbLYiwDCTszsaXMREe6SqsAoBPkAP5lN4bm9UijrZOxZa2x8I+cclU6bAmsF60JeQbKFs/vvAwsmE/yUUA69rUMq/NboP4ZOZw+sKz5C32yVksr4KUgReC77MGapVjGYYEXKi+WTIHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843697; c=relaxed/simple;
	bh=RJ9/qQ9if+Pw+0StHdvZPab8oEQ36zu13HUXm1EpHx0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ESawFrQ5XqT2yeRj/rTNYWyWd8SydCvRdlT6CEXuquD/gv2RvA2tVYqigORaitIypBrsKKkwA8j5ryQEYxtP0bvNNiiaMJXwDfC953Oig3TN5ldyEluasUdSUT5hDb1t0uh29glG5POU4zsCHttB8q78QkaSgiNJO9p00L/xUC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZFkqoGvd; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jh75iHqvk0/94lDpfJ42yOcZxfe5vXPzLtDIFwVfMCMQDbXQP905GFiL8CU2G+MJg7/M7Pk3Zzt0zbJMoYX9eg1RKg+ivoupB8KF7+5PecGJpKFv6ium688bVrueGoqb38/FIlq8Zw8uXS45EVzVTGDFHilbyNdnuKFYejtsu3ZU2e76HjRPouludAEy17JOmJKt+h6mSqo4dua47n9kTXjdXpD7lDjY+75rTk9h/H2CNRisbqsJgX5a/LBF21smzPhE/1Al/x2uuj+YoQ2yR3eyFHDRNNw+XLLAnJNpdtJHV02D/WrRHek1fkXAI1ajjMolTK/0rBHnnszJNT3cMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFDu44CG7TAoYA5tMuORa6hpmkQ4LmQ9RZ7D4oeL5tc=;
 b=wrLVNesIbUl3Bkr0Ul7ulhdXtR46aYSgYn7NojgNJYd6m/dTzOqu6x+c5RtC2cIPRmRNoUI5p61K1a98G1SrvJ3v0lf0Ow1bUB90cJfDvkTuJHiUdj2JTzrIXEeRxL13lFNoexFtEitgzn4dR8eB03stScRjAbZ39+0V2JAEsPPBtCOYUkt4OAJvS3zEf6g3Em17kiR2IAfE12IPb+VTa7pRNhLVptSRuSYui9ssWaqs5aiMtzDrY0AZO9eWGic+m9ymIriwDT6sIaNHS7RyjXsbKi64IJZLJk68bAphT2CaSac/PXSi+myfrGPXIfRQ+D9sOUFlMFIqGA5m3uffBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFDu44CG7TAoYA5tMuORa6hpmkQ4LmQ9RZ7D4oeL5tc=;
 b=ZFkqoGvdzxIyALaIhBnGWXAhvhdRuIOPV95I2Rcr5Lo3WPHlooyn9m8GchdEdKgPYmcoG6noa+aO+RgG2Cq9ejrqsLXIqUYj2KTRzdHfTDKVeEAeqC4gLso7Qr7Og66W7j0uhcPgDueb3KFmz40IE84S6kTWt2fIJTwhJ+0k0So=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by BN7PPF39B20C1D8.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 19:14:52 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 19:14:52 +0000
Message-ID: <874299e9-eb4f-7775-4ea4-69d449ca1e05@amd.com>
Date: Mon, 24 Mar 2025 14:14:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: query regarding SEV logic in early boot
To: Ard Biesheuvel <ardb@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
 linux-coco@lists.linux.dev
Cc: Borislav Petkov <bp@alien8.de>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>
References: <CAMj1kXHacRusnpmGJecMU3L2CCyQtopBL6KqoSVuF7tDW85TUg@mail.gmail.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXHacRusnpmGJecMU3L2CCyQtopBL6KqoSVuF7tDW85TUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0189.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::14) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|BN7PPF39B20C1D8:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6a835d-ae33-43d5-f37c-08dd6b082790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2JpTDd6cW1TWjhhdUZITmVJMDlYWmdDaTBvNXFNNDJZZFpIaGg2NzVoRjZz?=
 =?utf-8?B?OHcrMEkxU3Zab3VpcDViN0lPVm5rOWRaajlNaDBhaDJaQWcxWkcrS0hIb29q?=
 =?utf-8?B?NW9VRStxdlk5YWczczN1Tk92bUxJNHlqL28rMDRWVTA3TnRFUVY2MEQvQTI0?=
 =?utf-8?B?OThNRTUzRnE2SHBGSi9uVzhqczNiRkg5K1RMb21pWEFFNWdGRVd2T1dhZ3JW?=
 =?utf-8?B?eVl1M2FVSEZIVlAyZFVBZWZ1ck5uNXRtdjk1d1lLZG9MNTNZdkRMSlY2WG0z?=
 =?utf-8?B?UTRBblNKb2tLTUk2R00wMmJtcUFFWjI0MnhtNjFabFZDK2Y0MEt3L2tSMnZm?=
 =?utf-8?B?cHR5YnVGQ1B5bTJoa2cwVlEzcTV2dm9kYkVqZEFxaXpyYUhsQW1qOWI0akdW?=
 =?utf-8?B?aDNmamJVTWp5d09VVERjcklzMitRUG5pUjdUYXdSQ3ZNMzIrVFhrc2ZsYi9X?=
 =?utf-8?B?dXB4ZWZBemtPRXQrMFZMNE1wUkUyYlpJMU91TDA3enU5a1Y1YmcrQWw3d1BQ?=
 =?utf-8?B?NFlrOFJIYnhJdk9LZTlIWmNYUG12bXc2M0tpdjZTREtSazFqejNNMDg5Y2JW?=
 =?utf-8?B?RGl5YzFIR1VXYTk1U29zZDg1bFdRMytyaEVNcTBvREdja1FzSTYxRjRqNGN4?=
 =?utf-8?B?amZjNi84RjVOckIrOEFMSGpwNzZxSmY1ODJxUFowcnE2OXBZcWV1MDZ0T0Nk?=
 =?utf-8?B?TGlkcVQ3SHQxbUNLdlJKemRydVJPSXhWMzQwMVh1Ri9Ia2tqSUxWSHIyRTFz?=
 =?utf-8?B?VzRBekxYNWFwY1BJT2plcG0zMVJqdy9ueUYxSnZ3U212UDl3d1RGWEg5dGJ2?=
 =?utf-8?B?K3kwZkZGb291WWNLSDgxWEwyQnNLZnhLUlJReWoySGpNLzhyUDZaZ2xZWXBQ?=
 =?utf-8?B?NVFVRjJ5am52M0dqZWdxWUVEaXRTRDdkNU9zNEkvYXNhcG9OdDlLZkVYaDZ3?=
 =?utf-8?B?TUN6bmZnTUt0UHoySWMwWGNsckptUyt0OWFJUTNwclVpZTBWNExCZU5OMVdk?=
 =?utf-8?B?SFJ0ZFgyL2xpcUJTR0w3ZjRIalZmS1JTN0wyU2RSZ2hjMGVzUC9RbEJPdEZC?=
 =?utf-8?B?R09nYURJbWluUXF6TVhzZ3ZqRGovSWVwaTNDSlhkYXJnTEVEL0FHZENJbGVX?=
 =?utf-8?B?S2lTb0dpUUVlV2cveGN3cmI1SmEzVXdJNkIreXgxS3VDbCtkSVpGQVRWZEN0?=
 =?utf-8?B?VUVxNlMyYm0yUHI2MStzT3RjNEpmci9uYmxJMzVtUUpFcEhQQUlsUkIvMS9r?=
 =?utf-8?B?ODM3RFFwWnNmdUFoQ1FRWER0aUxZR3BadHNGS0M2UEV1aXVEQWV4RlNGblVw?=
 =?utf-8?B?N3UveWdnc1FVbGxOUm40M3pxcWw1V2Fsb2dZby9nVExveFZTR2xqY0dmNzdn?=
 =?utf-8?B?R3BBWS9NOFlRN2k2NldCYWQ3MnQxbmhiWHprb2lzMTRDcDY1ejhNWlR2azdN?=
 =?utf-8?B?cXdPWllIYytXcTdMZThxTVREYlVWR0tkZ1U0VXZaSk81UllOdnRMYjk2S0Fo?=
 =?utf-8?B?YnNWZG1uTkN2dzI2TTcyaVpwZ2JvMEJYU0thKy9XQi9GVWVWak5hcWVVcEU4?=
 =?utf-8?B?M0RpNGlHNVh6QmMzeEJkSWtSVjlLOWxjUVdFbE5Idk1ZTkJPZ1NFbldvUmtt?=
 =?utf-8?B?c2N3dU02ZDUzT0lCZXB1QUgrOWZJZHF0c0VXYjAxWnEyU2FxSHB6MXZVaFRT?=
 =?utf-8?B?RUpaMXk4MVdoek5KRmFqaWRGZWNFN2FtRW1ZeGJFbENqT0NtaHl4bFFNSlkw?=
 =?utf-8?B?Vk53UDQ5YTBGOCtOb3FQV3RrTzJ6cFhHSXBrMmhtSU9nTkRJMG4rUFhZSEpZ?=
 =?utf-8?B?clNOWjBGNzRrbnlHMGlLWnpKV3ZEeEtqMmg1a2FBYW1HZWtYVGNodU5RR1VV?=
 =?utf-8?Q?1gdr+bTT0zKKo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEp0ZCtoV3pabEJYR3FPdkd1RDQrNmJZRlJWMFFxUXkwb2ZJOGRqOVNaRFMx?=
 =?utf-8?B?VUFlNHdROFFoV2R6bDl1Zm1CYTVZUEhYOFR1Uy9VRnR1alFiZnBnekt0UnRG?=
 =?utf-8?B?SlpkSUJmVkNteWpaRWtsaEdjUGpNUFZUNm8yZldEWnFyajdpRFV4L3J0UWdO?=
 =?utf-8?B?bXRHaXlJU2wvS1ZJcEFidXZNZndtaTExaWlIOTkrMVRrZE5ad3ZrWmlmSVVJ?=
 =?utf-8?B?T2ZmdWVkbWtRa1dnakV5dlJCdGFCd1l4N0I1S0FPTUFpMC9zZ3BGc1FkamFr?=
 =?utf-8?B?UE5Zd0ZWMS9USmRCUmFFelR6VEsrczIxS2ZBQk1yUGViZ3dra1NLNlNjL0ZG?=
 =?utf-8?B?ODZQaHVOd3lkRmFsTnVZcWJIS1BPVzJ4NmxLZHJJaEIzVUhSWEJFWXZmajRu?=
 =?utf-8?B?d0dmanlEc0xWTjFzQ2k1TnRIdGsyTjZWQmNxSFlUTlRZU3NneXJuM2hKK0Rn?=
 =?utf-8?B?ZFBoOXFxVjlvTmhKZUdaL1ZiWGxhZFgrY214ZDZMRmcxZ2hlQVlrK3lwK0ZU?=
 =?utf-8?B?UWZDZFJna3hCSXhpVVBkM3RpVm1iUHNxQlVNS1J0RnhPdUJLSHRPcmN6SjBq?=
 =?utf-8?B?SUpLa2hRZ3NORmVBbUNmNW95QUZoakpZZTZkeVhZQXZod2lPM1lzeXp3c2Zz?=
 =?utf-8?B?bHhpZ2pLZDdmb0RxL0NnZHpMQ0lQbHFrL1JBRGFrVEZwT0V1YmR3ajc2RWM1?=
 =?utf-8?B?d2ZXc25RdTVzQTIzNHQxNEZNL0JHZXEycXZqUUpoNTJTRnFCMy90bUp0eStV?=
 =?utf-8?B?UVAzRlVwSzhzWUNsUy9waXN1OVhPaGtpcFZuTmdEbDF6aGtnelBkWGl5U1ZX?=
 =?utf-8?B?SzJrM2JPMlJqWkhDYWlXR3V2RFdFVTArcHRpS1B6SCs3c3B4bGtHcDZER0E2?=
 =?utf-8?B?cXBya1BybXNnMzlMQ213VzE1d1pLbmpBV011UGhoekxuL0xvWlNjVXBabm1o?=
 =?utf-8?B?YUxaZS9mK25XYTJuK0JaY2FJOHdzQTBSWEc1Z1F6bzZEVEVQeXNrQ282WVE2?=
 =?utf-8?B?QUlpNExsWlFxV3N2ZmRHN2pIRnZKaWo1Q2N1QXg2RGNwN2tWYmZmaHkzbm01?=
 =?utf-8?B?WTZKdmJsTTVDU1RkbXVtYktEOVlXbDNYV3NCb0NoL2lhWGNuOS9ncThTa3JU?=
 =?utf-8?B?Wm9JV29GanhzaHpHdkl1aDE3SWRpNFdwbUZKM1JsZGRsT2lQbHhqM05DMGQ4?=
 =?utf-8?B?QlA5NVBabm16a1B2Q2xqejZxYjVmeGh0T0VKTW52aHAwZFFlSzdZVEhJQWxH?=
 =?utf-8?B?ZkpiRU44NlF6M0RFcXJyZlBkYUxpSlZlVE1oVlo4ckxDclFWOG5WN3RpUk9R?=
 =?utf-8?B?UjVLYnFFSi9wdEpCL09oaGFxSExMT09BTUJvaWtlTnM5cEMvL2t6RnpMbURy?=
 =?utf-8?B?VnkxUGJnbTdqVDAzUGF0NUFqajYvMDE1SU4wS2VHRzdPNWpqKzlTOTdjcXJP?=
 =?utf-8?B?M2pudzZ5UldCZ0E3TkVGbWRCdm1qc3RsWmJHZTNhRzZpRmFYVWhvQzhyczNS?=
 =?utf-8?B?VzV4UXJ4Q2ovZGhRcjRwSGFOd3lPWHZZU2NwZHZnR3FUSEFZanRHMXVTYUZK?=
 =?utf-8?B?ZHd0OENXckpIVW5oZVFqVG9aTW1jQ3ZBS0pKZUtmcGQyVUJJOVVtYVZuNENG?=
 =?utf-8?B?S2paUkxJMm9VdmFnR3BSVDQxclIvZGpuZmhpSmFMWkJ2THJrSmZyZG5lZHhy?=
 =?utf-8?B?OUY2OXQrS0gvZC9qWWMvWENVdjU3UXp6MG1ZUUlLMDMwYW9VM1VTQVhSei8y?=
 =?utf-8?B?RWZiVUs0cHpxbE9sZ2F1NXRxRjYvTjc4aThFL09hb2VHb00zUE14MWZCUmp0?=
 =?utf-8?B?aXpGU1lWa2VPaXplalhpTkZFbFZQcklpckpVZ0E1TjdFU0h1Nnc5ZkhNci9i?=
 =?utf-8?B?SFNhaWg4QXFQbU9NVndWWW5kNFhBWnI2Y3R5eElLS1ZVUldNMzA0YVVkNFRq?=
 =?utf-8?B?ejd2RWw5elBCV2luSDVFZk1Gc3R5RzQ5ejdpemFZQStOUVdvS3dTTCtzNUpq?=
 =?utf-8?B?dmFoVUV5ZE1PQlBYZGhIOUpPZzBac1JVejRzY1NJQVRKMHJsWjY3R3AzYUhs?=
 =?utf-8?B?dE50WldDWnhFWU0rdmFRaGJ4WEtKWmNONVpsa3JaOC83ZzE4QUdneWl5ZlA1?=
 =?utf-8?Q?joFpyaHkmKl6IkORbJd7KEoeM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6a835d-ae33-43d5-f37c-08dd6b082790
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 19:14:52.6082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsXHsLJHBwS9NdeVlSTJp7F5+gXQlWLpDSykKgt0e3rj5ohMHJlR9EWq2mD7Oq6AtlUK9cq7Rb/nPGcYXYPFXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF39B20C1D8

On 3/24/25 12:28, Ard Biesheuvel wrote:
> L.S.,
> 
> As I am trying to disentangle the Linux early SEV boot code, the
> legacy decompressor and the EFI stub, I noticed something that looks
> broken to me, but I'm not quite sure how to fix it.
> 
> When booting via the EFI stub, the following call chain may occur:
> 
> setup_e820()
>  process_unaccepted_memory()
>   arch_accept_memory()
>    snp_accept_memory()
>     early_setup_ghcb()
>      set_page_decrypted()
>       set_clr_page_flags()
> 
> where the latter function relies on mapping_info to remap the GHCB
> page as unencrypted. However, when entering via the EFI stub, this
> struct is never initialized, and so I am struggling to see why this
> works at all.

The latter function reads from the target page so that the page gets
faulted in via do_boot_page_fault(). do_boot_page_fault() calls
kernel_add_identity_map(), which calls kernel_ident_mapping_init() and
initializes the mapping_info struct.

At least that is how it is supposed to happen coming through the
decompressor. I couldn't recreate the path you sited until I tried an odd
size memory argument that was not 2M aligned (using 4097M on the qemu
command line fixed that). However, even that causes issues, because the
SEV_STATUS MSR doesn't get read until sev_enable() is called, which is
called after setup_e820(), so we actually can't even take the
snp_accept_memory() path.

But faking the SEV_STATUS MSR value does cause the code to get down to the
set_clr_page_flags() function and reading the input address contents
doesn't trigger do_boot_page_fault() to run because load_stage2_idt()
hasn't been called, which probably wouldn't matter anyway since the code
is running under the EFI page tables.

So, yes, this does appear broken.

Thanks,
Tom

> 
> For context, I am looking into splitting/refactoring the decompressor
> SEV startup code and the kernel proper's SEV startup code, in order to
> a) use PIC codegen properly, and b) allow building a EFI-only bootable
> image that does not include all the exception handling and demand
> paging.
> 
> Any ideas?

