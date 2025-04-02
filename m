Return-Path: <linux-efi+bounces-3188-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC809A79523
	for <lists+linux-efi@lfdr.de>; Wed,  2 Apr 2025 20:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B2DE7A549F
	for <lists+linux-efi@lfdr.de>; Wed,  2 Apr 2025 18:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86AF19E826;
	Wed,  2 Apr 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M8xn95/3"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C712E3374
	for <linux-efi@vger.kernel.org>; Wed,  2 Apr 2025 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618729; cv=fail; b=PslEplYNi1DZgFbwvZfgC017U274mBCL4BPuM/Mw/dgXP2nzdME4mr7inkV8UybHnanjFXcSEqgYzL5K2vuPFUnK4fl7YiAmNYdmDqd30da279ypAXCxQMq9gHItQud2YzCutco6JX8qDW4v4DHxHvEgSy0QyBFkLDJRwWpMb9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618729; c=relaxed/simple;
	bh=8KWMAM+4MN4D1JNh2nulB/0Btfj3ZXj5PFjhF95NTEg=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=CSe/NQepaHl/dhyp8GGhJ9n8Tgh70VOEm79kHvXBurKrzim7QvxkG0jEgp/IBw5/CptV2CtgfeKE/XQj0bI8D8GgEeKWBKtK19bVFPrClJYbdK2nso1zZykNg5AMur0jEtRqlR1N3edMHnsgZxJnfBPknYh6WoiSU4OjedzYBnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M8xn95/3; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMdWYJomppsOPiXtHPPr4taoMS2D+Yrxm7MC+XhmR/zbqfnu9/+pwNXhLjuaOsH3I1YZGbDf6j5PemAPFZvd4t2oS+ADoXZgkCwiqxf2+I2nXzslfffojLsW9lAtk905PyqcbAMnNoyvyPKdmlgur7juiIaeIEUyZnjoED5JinJkNG9PySJjDFeHeGg8XjTiOh4iAVaD+D7fTHWp8OhbJzUdovpStknU6XUpCJFZVs2ydzuBp7Z16M46gyPvrYinnPmLNCdv97375bB9iXND1hccej7cgGr4K3wz0pnC9UG/cXrQkK1Ewb/xlR7olPYfqEDBxwhr08GzO24g2azg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yOxYN9aGKCSVqMcWdI9yyMhS+TQNiEZRV6lLzsO/5Q=;
 b=n31lFhx8DiaF5Va8lYL5Uc3C2OlEiRLfeZHSF9oGS5EgXpDr1v1bA0qld6hPTQZDXD2Ko2V2eC0BIYrDlVNYrkEQ91VmJhNJV4avg3yV0ZalvzIHZairZXgt2vVwhl77Wh+doNin7Td8TzBbhzWvCsbSwxjjrxWUkst5xhn2CSh4SgYjmztgPz4ZxLw6OGK2JPVWwlPkiK/QueTfeudXSW/J3j4iqbr/QyLp0055YR/uhHpXwFaZL/5RVcpJTJKj/Z650VldiqtHM20o6jjJekmQbIVKIi9HW4964ryNbPqEBmp9HOXHzPAUFZasPSqYu2IF9QNjMXD7Y9NyD7kEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yOxYN9aGKCSVqMcWdI9yyMhS+TQNiEZRV6lLzsO/5Q=;
 b=M8xn95/3mjOKRraiG/A3StZ3GQOTD/3E96EUwyPtNYLii8vZqOUvsqrA2usfIDh3RReN00Cl41GJZJiH2k8fTAd+ULyDDWoznG78oYxMcZ0Ozo1OVJIKcqudxjacJxjmlA41Af/t02TpPzBzJTPA/+JJXYcqaL/qU1skLrRsrx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 18:32:04 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 18:32:04 +0000
Message-ID: <afb6dc48-bde3-ffeb-19a3-70b1e5a15cd0@amd.com>
Date: Wed, 2 Apr 2025 13:32:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>
References: <20250325091614.1203411-2-ardb+git@google.com>
 <32zavhk2moqarh4vd76rnhwte45kkc3gqy3shls7mp5lemhy4k@o4gibpdf4sj6>
 <CAMj1kXHkM2hBHkfjFuCKpOA2APX+BBR-zrPfRkpiEf609UMKjw@mail.gmail.com>
 <ervuw7mwzvcyizkchy3nz4357ahz5kdfzc227exlrc5yabq4im@g2kzsrdbkdf6>
 <CAMj1kXEzzNnohJat5REp5mAUCSd4v_ft6F=P6vB95z6+f1MMfw@mail.gmail.com>
 <4xm3bmuhmdbnn6fkmhmnrtkcdiwj76dcr7gujam45nqvgupvj3@caytleltmyzj>
 <CAMj1kXFERrdioZ8_07rwDVUAoq=OLDvLCRUS6BN3GXnJoJPuAA@mail.gmail.com>
 <d6eb83a9-d1b1-7028-9cfd-1ab3fa0d6269@amd.com>
 <CAMj1kXE35QQ7b3uSF4Ufv6VXyjCfPyveUO1KLPKwsgoHu8iE=w@mail.gmail.com>
 <121a6769-3b86-b1a7-1d90-524cdd82790b@amd.com>
 <CAMj1kXEUARHvxQjucikoy_qWkrVnqsMGQyt7mUrBeV-f-_ZQJg@mail.gmail.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] efi/libstub: Do not accept parts of memory before
 ExitBootServices()
In-Reply-To: <CAMj1kXEUARHvxQjucikoy_qWkrVnqsMGQyt7mUrBeV-f-_ZQJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0166.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::10) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: f1fc4785-9ea7-495f-d0d9-08dd7214aa70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTdDUTJsT2pkNXczMVcya0NyM3VRb3h4dVBZSFpSZ3MyUjV5VE8yendYNjBO?=
 =?utf-8?B?U1dUb05wanBrYi8ySXdYTnZIVVJsQmdZTUppaWJRMFRaWDBsSUFpOEp2VmZn?=
 =?utf-8?B?dnJHRnE2NlY2OVJrdktEVjUrYjZHbTFXVGxxcGRHUkRwR1U5U3U1OHlDOFJC?=
 =?utf-8?B?S2VjOUVvNDJqcTFyTTh5azRZSGY3ZjFkR1hrQnovR1pNWmNYQTloWU9OUUds?=
 =?utf-8?B?bG5ZdThOcVRYNERkRThIN0ZJNW1DRjJPSnR2YnhTU1pDYWtUZ3pWV3BXWnlS?=
 =?utf-8?B?QSttMXc2MEZHemFOK1A2ekRCbi9HeDBRM0xCT0xPWmJyRENNa2hMaFI4L0l1?=
 =?utf-8?B?RjZJOXRnMWJkaktIbll5NWVFMHlINlFBaWRneG55eCtlZW50R1c0Y25rSmM3?=
 =?utf-8?B?aVN5OEp2dTJObWUyNitkaHFCTzNTM2x6R2xJZ0JkUGVEQjJmVWNaRElkOEJi?=
 =?utf-8?B?bUxZWklxQWlJK0RKM05QK1Y3cjVtSUhLaCtCYU5WQnlGbjdzeEQ4SEhKdjRr?=
 =?utf-8?B?Z0FCakt3Uks2L2o0alh6dk5YMnVQSlpEYVpYeTdVNE11Z2liZDRiNkcyOVNs?=
 =?utf-8?B?TUFMUGVQYlc0UjUxTjZvcnQxaHIwVUtTK2JrWVk4TDBvQVlTTnFEMTlveVA4?=
 =?utf-8?B?WHBHcUpFR2JpWHNqZ1JydnlBcDgyVllZTHM1V3g5TlJXUVpsY2RQRS8xWVhU?=
 =?utf-8?B?MnNSejVzcndaanpVTW5mYS9YVWdzUGFSVHdILzJXNVBKaGFWZDFGNkJJWVpx?=
 =?utf-8?B?S1VSR2NnbWpMbVZjdjVCY0hDRFQwMGFLaE8wR2FWV1JScVNkSjN1WUlPS2NE?=
 =?utf-8?B?SXEvUnZpNnJkUTNaU3MvYm94Mk1yR25xU0E4MmZlaDY0a1doMnVKVFA0K3Ny?=
 =?utf-8?B?TVgzL2M5dU9TMm9qK2syRXlQSUlaU2hhb3YzRzVzTTBnSEF5L0cxNWY4RjNT?=
 =?utf-8?B?MURlZTBLZG9YMnZXcEFMSVRwWmhFTE9iMVB5S29vSWgxYUlHQmlabk5jMUor?=
 =?utf-8?B?NHF1cEhZV0UxdnBJVVZTVnZRb25MaFFlR1dSK0pQOFhIcGp1NEg5SjdlZFdt?=
 =?utf-8?B?WDJOYURpUHg0QjdiQmtRUTA5amRjbC9KYmtEVnordVRSYjRtaFhNcURjQkR1?=
 =?utf-8?B?MWY0bTQ5cVpXZXBKTzF4aU9kbjNINzEySUhWQXhFZnZxSG82dTk5MDhWQTE0?=
 =?utf-8?B?NEVZdEtoMVY4VXZpTWdPMXQxczBKM2VDTUI1U2ZzUTlFeE5WNWFWN2NQN0tu?=
 =?utf-8?B?U3hKckpINWRobVFIQThyY2RDSHovRFRRZEQ5ODZ5cmlyVEd0elNKMXU2VWNN?=
 =?utf-8?B?QmR4TmdqWlI3T0Y3djVQTUlLMmtGOHBrdVFXMEdITFcwNWdkL3pjUDg2WWJX?=
 =?utf-8?B?V2ZmcmlMWlIxQ0x1cDd5VFpZYmJMQmJmNU5uOEZ0S2wybXRhN2hGbUxMZndM?=
 =?utf-8?B?YlR0ZE84eG1JWExVcVVDMnMxYVYxTkdoRnNPYTdER2tzS1VNWUR5L0p2UlBO?=
 =?utf-8?B?b242Rk4ycmVsM0RtMlZuUFRDODZQMHp4bUFrWExrc2txM3hjT0RmamNoMXNF?=
 =?utf-8?B?VnBXNTI5UytRM25mLy8zdU91Sm45VGt4dHN3dzg3QU54L2FmeS9RN0lxQllJ?=
 =?utf-8?B?czYyZkZtY0xydXZSRGZXRzZwY2FDWmRWdDRDUVlPSVdjY1M0YWxTZnRpdGYr?=
 =?utf-8?B?WlVackJ1bitVcEprcHlUWkw5dmNnTXc0bUpFN1pMZUlzZGpxUnNydk1UbEpU?=
 =?utf-8?B?NkNVSEo1UnRrb3ptU0laek9BYzRObXdkblFMR1pqZ3JOKzgwbWRxWVhuNHI5?=
 =?utf-8?B?ZzFBYWUwZzY5KzkyR3hydSsxYTlzMVdERkN6Vks4VzNZb1dhdFdISW9UamtX?=
 =?utf-8?Q?mfcdB2X18zknG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHZaWklGaW9qL1RSQSsycGsyZVVZWS95Nk50bnl2b2R1NHQ5M1dJUjNvY3Ba?=
 =?utf-8?B?M09ad3ArZ0hPSU9DSk9pQWFhaTRCWTNEWnlDZ0pxVlcybG1CMlZMdXB1S0dn?=
 =?utf-8?B?REZQKzY3MFgvRWltdkZ1NUYydWhodDlQU1QyN3dGNkNlOUt6UWtrOXN3TURz?=
 =?utf-8?B?cFNmdHhDeno5cVhnblpOenhXQVQrWk52Vy9iUnBNVjFMbVpIbm84UGswMkVN?=
 =?utf-8?B?L1E0c2RqOHBMZUVPeGxVVGZpNzZ0T3RNN2R4elRGNjNhdFV6N25YVHR4dFNr?=
 =?utf-8?B?dXpvL1YxYXFrVjRTQnZCT0JRN3dPY2xkaXlkVnRqTXgvelB4RUpFK0o0UENK?=
 =?utf-8?B?Vm5rdEJnSFJSaWFwamJ5ZHJqK1NiZG9BalJLb2xTTlROV212M1lZRFdTOHBu?=
 =?utf-8?B?WDBZaUozVmp1NkRobVo2M1lVU2wyUnF1MnBDTmEwMUhxby9hK0FDU1J0NXpQ?=
 =?utf-8?B?bzlMRmpESG40alZtZGZKbjJQSkw2R2hjVkM1bnlFN0FwbjBSYTVnNzRLQlQy?=
 =?utf-8?B?R0NleWw2bEhac1pESFNGdXpBdkZ4U2xhQnN4cHp3ZVQ1cDBxNHdvbElQTDdS?=
 =?utf-8?B?T2xFZWdFYzNITnBPczNQZmZsTHZzNVBsbm9uMURXbTlleGdOTlB1elZpZE96?=
 =?utf-8?B?VEwyeUYvMzkvR3lldE1xY3A5bEw4U1lLUCtRdU5oSTAzeUhWdWw3OEZRUm9M?=
 =?utf-8?B?WWxadUZQWDRBQllsc0NmZmhtV2ZGQ05xZTBXTTJDaW5IQ3hzK05iaGdxdHNQ?=
 =?utf-8?B?dS9CUXBIUFZLbllaMEZXbEUxVkJ6WWpQYzBxUWhGS3UvTWwwZEw4MkVVelZ6?=
 =?utf-8?B?SnNiTnYwWU5xeXNTRS9PMDJEVDl0Q3d3UTVYb2hKbDl4akxoK3RWM3JyRkhD?=
 =?utf-8?B?UlhIa2ZSbmpDcmZHbndJcGVjTUlJWWo3L2ViUnpaVnNveEJkZ3pNeFRoTHlx?=
 =?utf-8?B?ZU84NWtLM3V5KzFkMkY4QmN3YmFvVmhNdHNMdk9uU2M4QmRRalQ1UFZ5dVp6?=
 =?utf-8?B?dGVhakJFZmtNQXVSVEwyQTlFQTJmV0Rkc2pJaXVNYUM5b2E5L29qVjM4UTky?=
 =?utf-8?B?YWgxSzNta2lQUXVuU21iOUJvcVBKNlh4U0ZINkZIeWlOK3h3TjdjYTAwZjhl?=
 =?utf-8?B?Nis3SzE4SmV4eWo1TXIzM1kyU3pwWXFUS2Q4L050aHQ0V2tkV1V4ZUFkbDFM?=
 =?utf-8?B?cmRnSzNWVm5tYS9pUnZ2TmhLWTdpSWhzck9aQzZGQkI4a2FVa2pWQkpSQVFt?=
 =?utf-8?B?cDhxcVRWNXhINkQ5TWlLeXpxZlh5blRRbUFudU1lSUNzNlBHUXNKemJBUlNs?=
 =?utf-8?B?NWg0TElmS3VBbzRGQjhlUEJoNEZlZFJzUTJDYnh5Wk5kamFnWFovWjNaQ1hW?=
 =?utf-8?B?TXlaSkJmTlhnZGlrK0w5c2VKRnVOZStlRW9NUlR2Y3FBR3k3RGg5VFdFNjd2?=
 =?utf-8?B?TFVnMkZycUVaZjVYSFpjb3VvZVJWaXNBWFh5dUd2NEU5Q28xY0pVN1A1SVp2?=
 =?utf-8?B?TWZVc1FISzZTU0FkZ1Y3bXVQQ3Y1cDVqYUJySkE0cjVRR2NXaU1ibXNpUll3?=
 =?utf-8?B?SVZxVXcwa1lQbkdyUERlaU5WL1VKOTYzZHlibkxjQ253eUNDRkZjT1pEeXRP?=
 =?utf-8?B?alVUREl6dnM4MGM2MU1BbUc5UWJGdnIzOGRiWWV5Y21leXVVRmR3U3VxRGhI?=
 =?utf-8?B?QVdnN0tueE5MajlzRmRQK1p2cDROT29iSXQrQmZqOStDam1zZHdCdm5WQW9T?=
 =?utf-8?B?M1owWlZkNDVWRCthdFdlcVJra0ZNR2tKQ1NaZ1kyZWxJRit3ZnpPUzlrOTdv?=
 =?utf-8?B?aGNZcFJMZWZXL3huMG1KYTQzT3FqbWtweGpUKzM5K2VFRHdwcnorc1BCSjQ2?=
 =?utf-8?B?eTlydzVUZFJkUXF5RWF6OGJtSUJuQjYyWm5CazJnQ2crRVNJM1R3cjc4Titp?=
 =?utf-8?B?UFZlZFhqODhtUmlROVg4SmhuUHY2Q2Zsd29Xb083MVRjb20xUkNDMExIOTJE?=
 =?utf-8?B?MUZEMVpxM2RlRTNnSGxjTlJuekE3U1RMR2JsL0U2d2ZmWHllUHBzOThTTS9H?=
 =?utf-8?B?WllBVXk3VU1ibHNoK05La0tDZktONmw0c1ovaXlSWitIOXNyNWFITU5aYzUz?=
 =?utf-8?Q?3Njyo1awbULBky8lZTlNuPETr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fc4785-9ea7-495f-d0d9-08dd7214aa70
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 18:32:04.2874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xILFMUHitQKoUdCNP5rOeOGkO/X81N4LnnezneuHBVdjJ8jFUn1osvszYMi7AtVu3fDeUjiAw3BHRgM/uA8w0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788

On 4/1/25 13:45, Ard Biesheuvel wrote:
> On Tue, 1 Apr 2025 at 18:51, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 3/26/25 04:28, Ard Biesheuvel wrote:
>>> On Tue, 25 Mar 2025 at 17:30, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>
>>>> On 3/25/25 09:39, Ard Biesheuvel wrote:
>>>>> On Tue, 25 Mar 2025 at 14:44, Kirill A. Shutemov
>>>>> <kirill.shutemov@linux.intel.com> wrote:
>>>>>>
>>>>>> On Tue, Mar 25, 2025 at 02:09:54PM +0100, Ard Biesheuvel wrote:
>>>>>>>> Since the problem happens before ExitBootServices(), can we allocate this
>>>>>>>> memory range with EFI API and free it back?
>>>>>>>>
>>>>>>>
>>>>>>> In principle, yes - we could allocate these misaligned chunks as
>>>>>>> EfiLoaderData, and it wouldn't even be necessary to free them, as they
>>>>>>> would become available to the OS automatically.
>>>>>>>
>>>>>>> But doing this in setup_e820() is tricky, because every page
>>>>>>> allocation modifies the EFI memory map, and we may have to restart
>>>>>>> from the beginning. And there is no guarantee that some asynchronous
>>>>>>> event in the firmware context does not attempt to allocate some pages,
>>>>>>> in a way that might result in another misaligned unaccepted region.
>>>>>>
>>>>>> Looking again at the code, setup_e820() (and therefore
>>>>>> process_unaccepted_memory()) called after efi_exit_boot_services() in
>>>>>> exit_boot(), so we can't use EFI API to allocate memory.
>>>>>>
>>>>>
>>>>> Ah yes, I misremembered that. It also means that it is fine in
>>>>> principle to take over the communication with the hypervisor.
>>>>>
>>>>> However, this is still tricky, because on SEV-SNP, accepting memory
>>>>> appears to rely on the GHCB page based communication being enabled,
>>>>> and this involves mapping it down to a single page so the C bit can be
>>>>> cleared. It would be nice if we could simply use the MSR based
>>>>> protocol for accepting memory.
>>>>
>>>> We can probably do something along this line since there is an existing
>>>> function, __page_state_change(), that performs MSR protocol PSC. If we
>>>> change the arch_accept_memory() calls in process_unaccepted_memory() to
>>>> arch_accept_memory_early() then we can differentiate between this early
>>>> alignment setup timeframe. The early function can also use
>>>> sev_get_status() instead of sev_snp_enabled().
>>>>
>>>> Let me mess around with it a bit and see what I come up with.
>>>>
>>>
>>> Cheers.
>>
>> This is what I came up with below. @Ard and @Kirill, let me know if it
>> looks ok to you and, if so, I'll submit a formal patch where we can work
>> on naming, etc.
>>
> 
> Thanks for putting this together.
> 
> Some questions below.
> 
>>>
>>> So IIUC, it would be sufficient to check sev_get_status() against
>>> MSR_AMD64_SEV_SNP_ENABLED, and use the PSC MSR to transition each
>>> unaccepted page that is in the misaligned head or tail of the region
>>> to private.
>>>
>>> Pardon my ignorance, but does that mean that in principle,
>>> sev_enable() et al could be deferred to early startup of the kernel
>>> proper (where the other SEV startup code lives) ?
>>
>> I'm not sure if it can be. There is a bunch of code in the sev_enable()
>> path that I'm not sure can be moved. I'd have to look a lot closer to
>> determine that.
>>
>> Thanks,
>> Tom
>>
>>>
>>> We have been playing whack-a-mole with PIC codegen issues there, and
>>> so it might make sense to consolidate that logic into a single [PIC]
>>> chunk of code that is somewhat isolated from the rest of the code
>>> (like the kernel/pi code on arm64)
>>
>> diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
>> index dbba332e4a12..b115a73ca25e 100644
>> --- a/arch/x86/boot/compressed/mem.c
>> +++ b/arch/x86/boot/compressed/mem.c
>> @@ -32,19 +32,42 @@ static bool early_is_tdx_guest(void)
>>         return is_tdx;
>>  }
>>
>> -void arch_accept_memory(phys_addr_t start, phys_addr_t end)
>> +static bool is_sev_snp_enabled(bool early)
>> +{
>> +       return early ? early_sev_snp_enabled() : sev_snp_enabled();
> 
> Why is the latter test not suitable early on? Simply because
> sev_status is not initialized yet?

Right. I was following the example of calling sev_get_status() before
sev_enable() has been invoked.

> 
>> +}
>> +
>> +static void __arch_accept_memory(phys_addr_t start, phys_addr_t end, bool early)
>>  {
>>         /* Platform-specific memory-acceptance call goes here */
>>         if (early_is_tdx_guest()) {
>>                 if (!tdx_accept_memory(start, end))
>>                         panic("TDX: Failed to accept memory\n");
>> -       } else if (sev_snp_enabled()) {
>> -               snp_accept_memory(start, end);
>> +       } else if (is_sev_snp_enabled(early)) {
>> +               /*
>> +                * Calls when memory acceptance is being setup require SNP
>> +                * to use the GHCB protocol because the current pagetable
>> +                * mappings can't change the early GHCB page to shared.
>> +                */
>> +               if (early)
> 
> I think it would be better to structure this slightly differently.
> I'll have a stab at this myself and get back to you.

Sounds good.

> 
>> +                       snp_accept_memory_early(start, end);
>> +               else
>> +                       snp_accept_memory(start, end);
>>         } else {
>>                 error("Cannot accept memory: unknown platform\n");
>>         }
>>  }
>>
>> +void arch_accept_memory(phys_addr_t start, phys_addr_t end)
>> +{
>> +       __arch_accept_memory(start, end, false);
>> +}
>> +
>> +void arch_accept_memory_early(phys_addr_t start, phys_addr_t end)
>> +{
>> +       __arch_accept_memory(start, end, true);
>> +}
>> +
>>  bool init_unaccepted_memory(void)
>>  {
>>         guid_t guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
>> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
>> index bb55934c1cee..162484d662f1 100644
>> --- a/arch/x86/boot/compressed/sev.c
>> +++ b/arch/x86/boot/compressed/sev.c
>> @@ -157,6 +157,12 @@ static int svsm_perform_call_protocol(struct svsm_call *call)
>>         return ret;
>>  }
>>
>> +/* Used before sev_enable() has been called during unaccepted memory init */
>> +bool early_sev_snp_enabled(void)
>> +{
>> +       return sev_get_status() & MSR_AMD64_SEV_SNP_ENABLED;
>> +}
>> +
>>  bool sev_snp_enabled(void)
>>  {
>>         return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
>> @@ -164,10 +170,7 @@ bool sev_snp_enabled(void)
>>
>>  static void __page_state_change(unsigned long paddr, enum psc_op op)
>>  {
>> -       u64 val;
>> -
>> -       if (!sev_snp_enabled())
>> -               return;
>> +       u64 val, msr;
>>
> 
> Could you explain how the below code now knows how to decide whether
> to use the MSR protocol or the GHCB page based one?

The __page_state_change() routine only performs the MSR protocol version
of a page state change, no decision is made between the two at this stage.

> 
>>         /*
>>          * If private -> shared then invalidate the page before requesting the
>> @@ -176,6 +179,9 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
>>         if (op == SNP_PAGE_STATE_SHARED)
>>                 pvalidate_4k_page(paddr, paddr, false);
>>
>> +       /* Save the current GHCB MSR value */
>> +       msr = sev_es_rd_ghcb_msr();
>> +
>>         /* Issue VMGEXIT to change the page state in RMP table. */
>>         sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
>>         VMGEXIT();
>> @@ -185,6 +191,9 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
>>         if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
>>                 sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
>>
>> +       /* Restore the GHCB MSR value */
>> +       sev_es_wr_ghcb_msr(msr);
>> +
>>         /*
>>          * Now that page state is changed in the RMP table, validate it so that it is
>>          * consistent with the RMP entry.
>> @@ -195,11 +204,17 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
>>
>>  void snp_set_page_private(unsigned long paddr)
>>  {
>> +       if (!sev_snp_enabled())
>> +               return;
>> +
>>         __page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
>>  }
>>
>>  void snp_set_page_shared(unsigned long paddr)
>>  {
>> +       if (!sev_snp_enabled())
>> +               return;
>> +
>>         __page_state_change(paddr, SNP_PAGE_STATE_SHARED);
>>  }
>>
>> @@ -261,6 +276,11 @@ static phys_addr_t __snp_accept_memory(struct snp_psc_desc *desc,
>>         return pa;
>>  }
>>
>> +/*
>> + * The memory acceptance support uses the boot GHCB page to perform
>> + * the required page state change operation before validating the
>> + * pages.
>> + */
>>  void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>>  {
>>         struct snp_psc_desc desc = {};
>> @@ -275,6 +295,23 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>>                 pa = __snp_accept_memory(&desc, pa, end);
>>  }
>>
>> +/*
>> + * The early version of memory acceptance is needed when being called
>> + * from the EFI stub driver. The pagetable manipulation to mark the
>> + * boot GHCB page as shared can't be performed at this stage, so use
>> + * the GHCB page state change MSR protocol instead.
>> + */
>> +void snp_accept_memory_early(phys_addr_t start, phys_addr_t end)
>> +{
>> +       phys_addr_t pa;
>> +
>> +       pa = start;
>> +       while (pa < end) {
> 
> Nit: please make this
> 
> for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
> 
> and drop the braces

Doh! Yes.

> 
>> +               __page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
>> +               pa += PAGE_SIZE;
>> +       }
>> +}
>> +
>>  void sev_es_shutdown_ghcb(void)
>>  {
>>         if (!boot_ghcb)
>> diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
>> index fc725a981b09..8a135c9c043a 100644
>> --- a/arch/x86/boot/compressed/sev.h
>> +++ b/arch/x86/boot/compressed/sev.h
>> @@ -10,13 +10,17 @@
>>
>>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>>
>> +bool early_sev_snp_enabled(void);
>>  bool sev_snp_enabled(void);
>>  void snp_accept_memory(phys_addr_t start, phys_addr_t end);
>> +void snp_accept_memory_early(phys_addr_t start, phys_addr_t end);
>>
>>  #else
>>
>> +static inline bool early_sev_snp_enabled(void) { return false; }
>>  static inline bool sev_snp_enabled(void) { return false; }
>>  static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
>> +static inline void snp_accept_memory_early(phys_addr_t start, phys_addr_t end) { }
>>
>>  #endif
>>
>> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
>> index d96d4494070d..676aa30df52e 100644
>> --- a/drivers/firmware/efi/libstub/efistub.h
>> +++ b/drivers/firmware/efi/libstub/efistub.h
>> @@ -1233,5 +1233,6 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
>>  void process_unaccepted_memory(u64 start, u64 end);
>>  void accept_memory(phys_addr_t start, unsigned long size);
>>  void arch_accept_memory(phys_addr_t start, phys_addr_t end);
>> +void arch_accept_memory_early(phys_addr_t start, phys_addr_t end);
>>
>>  #endif
>> diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
>> index 757dbe734a47..1955eddc85f1 100644
>> --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
>> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
>> @@ -118,7 +118,7 @@ void process_unaccepted_memory(u64 start, u64 end)
>>          * immediately accepted in its entirety.
>>          */
>>         if (end - start < 2 * unit_size) {
>> -               arch_accept_memory(start, end);
>> +               arch_accept_memory_early(start, end);
>>                 return;
>>         }
>>
>> @@ -129,13 +129,13 @@ void process_unaccepted_memory(u64 start, u64 end)
>>
>>         /* Immediately accept a <unit_size piece at the start: */
>>         if (start & unit_mask) {
>> -               arch_accept_memory(start, round_up(start, unit_size));
>> +               arch_accept_memory_early(start, round_up(start, unit_size));
>>                 start = round_up(start, unit_size);
>>         }
>>
>>         /* Immediately accept a <unit_size piece at the end: */
>>         if (end & unit_mask) {
>> -               arch_accept_memory(round_down(end, unit_size), end);
>> +               arch_accept_memory_early(round_down(end, unit_size), end);
>>                 end = round_down(end, unit_size);
>>         }
>>
>> @@ -144,8 +144,8 @@ void process_unaccepted_memory(u64 start, u64 end)
>>          * into the bitmap.
>>          */
>>         if (start < unaccepted_table->phys_base) {
>> -               arch_accept_memory(start,
>> -                                  min(unaccepted_table->phys_base, end));
>> +               arch_accept_memory_early(start,
>> +                                        min(unaccepted_table->phys_base, end));
>>                 start = unaccepted_table->phys_base;
>>         }
>>
>> @@ -165,7 +165,7 @@ void process_unaccepted_memory(u64 start, u64 end)
>>                              unaccepted_table->phys_base;
>>                 phys_end = end + unaccepted_table->phys_base;
>>
>> -               arch_accept_memory(phys_start, phys_end);
>> +               arch_accept_memory_early(phys_start, phys_end);
>>                 end = bitmap_size * unit_size * BITS_PER_BYTE;
>>         }
>>
>>
>>

