Return-Path: <linux-efi+bounces-4386-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8838B077FE
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 16:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5819F4E1147
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 14:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAB2230BF8;
	Wed, 16 Jul 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fnWHVimi"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE33C23BD1B;
	Wed, 16 Jul 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676051; cv=fail; b=l0UUfUJVw83fQ4ohOBfer4km5GX2X4Xw2BmzRA21SCUXyKuKUmelX4co3Yk7ucWuyFrp87sX0JSqP85j+j/sQW5Au3kq5pEf9Ih/pxSO1gZIQtvY9yb4vdbYMCTYEmi9k+v8Bg4rMNVm6J8/lZIieJDJC2hY6mMDkEgvOhG0MjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676051; c=relaxed/simple;
	bh=7mpRyD35X7vkoLRFPiRLjAtb0+wqw8DrgIGfxywjWC8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o7gQcDmFGpkxo35kcq116PQoiGcNRtFegC7VsGH3GXW7nt6EW9Sn/OCE+4o5zPTebvTcpqhpP8yYlr/EFVwwYwbIf0BqwfPMAhn5SXqdtEqQz2zop2pyEUPhVlpaMRU98Zr9/CvXfWDD/qvXryuqjlSjoMPX5xLT4ZRKV5KGjjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fnWHVimi; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/7YYTFG6Bi1tISBr8o4xrK6b9FS+iwVbApsFL56HcwRHSdxZ1SlfZJZELutiU4qRKTGs1An0vZhjMAFd6vdIAD4YURZC2IvW2ezkYECfKlUG6E7cD1TV0ZV96xUvS+187svtzaa1kpIDEGDW2kldkypYS47It5QE2MF3kku0av8zq+Dhj9VQ2RDfh0snK4Lc1Ii2Gdl9mYhalT2fJNAoEspb5JZOfRi/4zX+niytPsu8gTATAqis7D3071AzR6Nz0WTLI+7TtWb2gsObF1Mtf/GpQXiKOkYsX6q2cZvQBkgYXyLd2ofvF5sV+8WG8AKSk6xy9hJEvABBgxDaNyvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMoGBBBwBx+9r5Ub8jcrc7U5pz5U5wcwZJqRTfKj1v0=;
 b=kSMNPfMwd/PpVA6bJFm9nRFBfkl2jBeCPYJ/Ob4jsgltnhL5jjgn1JnTLMrN+/jUn1Iy+9Fm4AKoLrm5Lm2eQX4aIPY46/paCESw7a4fZpImV+/YAj1dDX7Y+9zuK85fJNT7WNGQOVqWfuKUKkYQz2ZU+wPC1yekyrXn8waGsgdZAdDxMkkKrsBq8UhTGMJ2w3sk3Yg8OKiwJBBW5q5fITaaRHpWvGAuzHhPqc1xYfNgGtpbwbgTK3Ji2ykRrbwBWJbmM4WIl4yPfvL/9CiXMfqt3liczuTnqoWecrmn4I2HLuLf59JimweWU1JA2eYPDjWYMF50oRFpUCnoXSDIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMoGBBBwBx+9r5Ub8jcrc7U5pz5U5wcwZJqRTfKj1v0=;
 b=fnWHVimipxtcL5yit6rVIujYed6GGLcjJsu7JzT6syiZD+Flep0a5zYhnP+iawAC6ntSf8d2RX1FP7yx+wPuIEK4KQNo2ApitxKglFM99XFRKxOKfT+VVcFKNJVy7Zg2kjAJo3U0Tb84HVELlYPi9ob+F5U/+OuU4/Q65dmz+mI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 14:27:26 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8922.035; Wed, 16 Jul 2025
 14:27:25 +0000
Message-ID: <6b5e2a11-b157-1288-f99b-cd8c7b8180d0@amd.com>
Date: Wed, 16 Jul 2025 09:27:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 00/22] x86: strict separation of startup code
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Nikunj A Dadhania <nikunj@amd.com>
References: <20250716031814.2096113-24-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::19) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d6d8a31-b702-4f34-81a5-08ddc474e29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGMzbUx5NzR1WDdaNnRZNG9abkdIbUQySVhsWjhLUjJSUmZPaHpFaVpxVzZG?=
 =?utf-8?B?czBYNTEvRmFrRkh5OWk4Y09QSmNxamgwZnpsVU9YaDhNamdlR2xIUGVBOU9q?=
 =?utf-8?B?bTZZbGlXWS9KT0tFbHI4VzFXM1BST29xL21HQmZtOG1LKzZxY2paMjZpTGtw?=
 =?utf-8?B?cHRuYlZhUUNqYncwUzFUR3c4M2tsWDNRZkpkWFY5eXV2YmlDZnErL0FHMjE5?=
 =?utf-8?B?ZjQvcjVucDA0dlZzczJ6Qm5seWl1ZE5QMkVxRXNkWVVNaENUdzhVNE41SUlh?=
 =?utf-8?B?RWZGdEpESGJyc2lzeS93cG5RRG5pSGErcWs2amNvMTNTaEdYL3NNUnRWcTlZ?=
 =?utf-8?B?WU9IczE0MEpyejk1WGpJenhHLzRaSFpwVldvY2tJMGdkZTlJekR4dmJIQWJE?=
 =?utf-8?B?MjV1b2xlVjMrYTFrZHBRMi8zSG5DS3prOVZRcDFCTnVJemxCL0JnNEFtdzhz?=
 =?utf-8?B?Qm5QNjZMQWF6dG5xS1A3WEFqY29BVk0rajhzNzJQMDlzQUlpamlNeG1xZ3dj?=
 =?utf-8?B?aXJrSjBHbm4xdVVuSFVDSzZFNmpYQ1ZtSmZic1Y0Z2ZqcTlQY1dETGUvellC?=
 =?utf-8?B?QlY0SkhpeUVoOS9OZ0k5MStHN25KVmJsNm9TMUVSQUJ0NlAvemF2dkxCalJG?=
 =?utf-8?B?eGYrM1JaWXNBRlJ2RzFYOUx3MUNkQURDNmk2TC85djJDeXRobnRhTkYvV3l3?=
 =?utf-8?B?SUo1YXF6eUl0bnFkcG9WQzVJT011NE1vZzR3M0d1YmF0Y0RONnJ5WFdFWVl1?=
 =?utf-8?B?Y3FyQURDUGllMFo1aUZSUDdncUpWRHRydG1kcGdUdXdqT1FoWHpicllUMGpw?=
 =?utf-8?B?RGZtblZtWDU2Z2tySHNBUFJGckIvRGNlNXVkd2l1ZFQ4WjhnMjlGRTBtc0E0?=
 =?utf-8?B?K3dMMXRxNXA2bkRBWkwvMnBpdjJUdGZoTWVPdE5wczBlZE9LSnRVbUlHYXdq?=
 =?utf-8?B?blo1U1ZHeVU0RUxjTmpaeW1TaWpjZ3RyVk0xTGEzWWtPQlJvemhiUjNYdkxu?=
 =?utf-8?B?bE1COGtjRS9yaFQrMnd4SUpLQzhLckxZSEMvbGE3a3JDZzdPT05NbGkyMlNk?=
 =?utf-8?B?QVRKdC9wSmZqNUF0M1RvREZTTTc3aG9iWVdNaldyeEdVSE5aZnFmaHNtRi81?=
 =?utf-8?B?V2U0dnVsMTRaU2NZbFZPTXpKL01qV1VoOGpaVW5WUTVtS2cvSFFtYnpiS0U4?=
 =?utf-8?B?bXUwK0Fkc2x4T3FlRUczSU5KL055eEl3YUlqejAyUHJBM2ZXTmh5YWVzQ1Iz?=
 =?utf-8?B?NjNmVG1jbWJiRVNPdjVMODJseGpIazJ1aVNIMWNFejdDOGZUYUZ5VkE3NERZ?=
 =?utf-8?B?UUJ4V3R0YzREZFVZeDJnejhhazFpTStTbUtTaTc5MGxsTXBWdzQvV2xpZGlK?=
 =?utf-8?B?VCtwbVFKVkdnWFl2QjZHMDlVL2xiMTlmTU9Xb2tkZ012UllaU05ybDkzT1Np?=
 =?utf-8?B?Sldhdm9YS2NtT3U3VjJnL3l6elIvQ2xwQ1hhV0ZabmtwYWRyeU92b2JjLzlL?=
 =?utf-8?B?enFZeERiWlZ5K2NsUnZld3JTWEJvVUNDMVZSWWRVMXJWalc3SVhRL2dqeXNq?=
 =?utf-8?B?R1FWUTk4Uy9RZDJJZFdTVWw0ZHhiRENrZzFlVE1iSllZWEgvZDhwbkV4bGZr?=
 =?utf-8?B?YkhBRzBEdkRMcjUrQlhxVGV6YjhKYXU2MytCc3Vjb0d5NEU2ajliWGZieVVG?=
 =?utf-8?B?ems0emg3UWRBT0M5SDVFbzJOMmFaUTEzRTRSZmdVOC9nVjlkQVlFVnN0S2Jn?=
 =?utf-8?B?d2tPZ3ltdkh3T0ltRVNRcHZaS2RGdWZyRENLWm42RzBMbTgwTjF1L0JFOVlQ?=
 =?utf-8?B?bEtneURYRXhROXNOQ3FScmUrQnI4ejkyMzhGbGx5TUYvU0IxeFB0Zzd3cGFh?=
 =?utf-8?B?RkhPa0JQeEZ4NzBHSW1yZ1phN2VoaU5wcVRSR3E2ZDl4UTg1clprSjhMVFFH?=
 =?utf-8?Q?9pxDd4s6Na0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnA5ZmZ1TFFJTkljMkdaMHVGTmhhUWVUQ2ovY3dJUlQ0a2J2THJOL3krUHg0?=
 =?utf-8?B?bXFaTy9WemVWV282bTAxSjVFQnFMZlJZVHpwWUNxc2hFZ2VtVzVyWlErRDdI?=
 =?utf-8?B?a1FSSE5WQXUxeTUrZUQwVHp2MC9GeUphUnhnVmgwdU4zVmRhSFM1QUY0OHBs?=
 =?utf-8?B?amdibVYrTWVYakpiY0ZFSnk2ZzFqMEx6QW9VaXJJUmR0b3FJOHZ5NFQvRGxI?=
 =?utf-8?B?cU5nQjJSTDhjb1QxZ0JwRlZzRFZkbGxFdVk5bGdGckdYKy9RMHhwZjB1MElX?=
 =?utf-8?B?WXJMTWFLVVFvSHJ4TWY4SkZlYUE5UVhsK1Y0U1k4dGRNbWoySk1BMjR6Rllq?=
 =?utf-8?B?VTBRYzA4cXQxaHBtbC9rR25GeHVXUmEyOGlTZlRLV29lQ0FZVENzdUpNNFZl?=
 =?utf-8?B?TldkNFk3RzZCcHEzTmt3WkpPUVJCamNQTithVmpyaFlsdDhia2RFWUdQWGVT?=
 =?utf-8?B?YWVUYTg1SmI0T3VpbldJdzE4Ymg0RGU3eVIyenVVVmZ1TlpWTHd0eFdDWEtQ?=
 =?utf-8?B?RkpOcW5iblQ0WnhZZU9keG9KbU1HS05lbzRwa3ZTQ0RmVFBxd0tMVnltOTR6?=
 =?utf-8?B?VzlZaGZvY1V3dzZUUkltZFY4cXRqVWl1V1dIWU8wSVhSSzhaTTQyaWVQeEw4?=
 =?utf-8?B?L0UxMy9kb2VSN0xGRjdWN3pKYTN0dFhqRFp4dFBKYjdCQS8yWkFGeDBoMlBM?=
 =?utf-8?B?blZxUlUxWTM0Y1VnalcxNmNjdHBpYTBLWXBvTTBQRURjS1Q0UnlGcnNVMW5T?=
 =?utf-8?B?M0tUdm55Rm0yWDF2bm5SK2VkcGZlbUhMZHliYU56RDVqakxNMVZhS04wWlBP?=
 =?utf-8?B?dDJUZDRYZ1FqeGs0bnNwTjRKM1lXeGhMbWJNSXBNTXgrY1NiUjJTL3dNMGtT?=
 =?utf-8?B?ZzI3VnlBMXlPWDNxUkl1YjVBeEVLS3hJc1B1dE1xelg4aFJNUjYwbFZ5ZEVa?=
 =?utf-8?B?cDVPNGRmd3kvMlpNaXhxaE52dnRDbFZoQlJyeXFyQ1ZyemFHbEliUU5sN3NO?=
 =?utf-8?B?Z2xKOUswNDFKUWdHYXBWK2VHSUFyL1lDa1pDOFFhU3Rza0FEQUlzWllmWWJq?=
 =?utf-8?B?TVRObjJQZzRYRGFuR3FuL3J1STNtdVVHTVpEZzR6MHVXVjBQTFE3cXlyOWds?=
 =?utf-8?B?T0kxZXpPYmtKSDVYekFtaE9HN2RtRG5PNU9LbFZtdW9tOGdCZko5RzNuQi9Y?=
 =?utf-8?B?R0FhbmVoejhyR2ZqNi9paUtRWC9XdTI1WE5yNDBlUE1SUS9ZL29tNlZrQllG?=
 =?utf-8?B?ZCtiWk9YN3BKdjdNdk1JaFdLQjAyOFh1NmR6SWVQM2huUW51Sm5lS3ZSOXU1?=
 =?utf-8?B?S2VPUFdZS2lQZ0U5Wi9nZTh2cG5lazkyTXFmVzhWSEJnbFFwVHNKU0RnaGha?=
 =?utf-8?B?SExlSVFJejVMUWFWZmJobFZ5cWcxR1pBcDBLeVNZL1ZVV3NURFA1N3ltdHNB?=
 =?utf-8?B?TFR2VFZ0M295b2RoWk9wcGFGTFpaZzlTWnZqbWkyY1IzMFRMSExNTHMrSS9T?=
 =?utf-8?B?QUc0VGhRNW9qbnRRem9EVVl4VnoyYlpXRFpKcVhyN3NQWGQ4MlViaEFBYU1p?=
 =?utf-8?B?NDBTaFlRZ3hiUE5aekVGYk41R28vTStKY0lWdC9CcnI3OGNteVh5R3NwaldQ?=
 =?utf-8?B?Smd5QkNxZEhvUVJHcVVLTDdLRTFlRkVnT0xObTVpU1dSUHFuSXg5V2R0UFZk?=
 =?utf-8?B?bzJsNE52dDVEQUZHMlZEY1FnSVJZMjBMWFRyZEhPQlpRRWFEVWY4aWlkY3Iy?=
 =?utf-8?B?QkFRWWJia2xGRGFLUklyck9xQWt6MWxUOTJid2lOMm42SXI2M01ndjdDdncy?=
 =?utf-8?B?K2FFVGc2VG52WmVyTkJ2K3JmTVdMNUJsS0dKOUFlWVhpZ1l4aDJJNUVmZGxD?=
 =?utf-8?B?SkJvRG9XYnp5WFFhZkF5S3FiY1JML3lHTmlqeE8rYVRCQmRFZDcyN0o0Y3Nt?=
 =?utf-8?B?M01XbWp3eWhGK09vWU9kaDN1cEhicTdWdUhXV29KR0RVZHd2NldFOVFSbkFn?=
 =?utf-8?B?ZkIvYmkybTFJcytzd3lTQjhXYy96NGRSeDVySmNBdlJIQ1czWXJqbmQ5Rml0?=
 =?utf-8?B?eWV4VzlJU2YwQ2F6MVpsc1JtZWI4dEtCWnVOcXZBbWZzNHpHMk92WTNKdnk4?=
 =?utf-8?Q?n8az4V8iMrGF75gwsrjemCYOI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6d8a31-b702-4f34-81a5-08ddc474e29f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:27:25.7944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3n6yElWQI/mm0v6Ys+mPgWrhbV6qYbqJwkM+k7VB/CRotehwUOAB/sQX3ZalvbPshjusFa4yZQ6P8DPlUwBbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956

On 7/15/25 22:18, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>

Hi Ard,

I tried to apply this to tip/master but ran into conflicts. What commit
is the series based on?

Thanks,
Tom

> 
> This series implements a strict separation between startup code and
> ordinary code, where startup code is built in a way that tolerates being
> invoked from the initial 1:1 mapping of memory.
> 
> The existing approach of emitting this code into .head.text and checking
> for absolute relocations in that section is not 100% safe, and produces
> diagnostics that are sometimes difficult to interpret. [0]
> 
> Instead, rely on symbol prefixes, similar to how this is implemented for
> the EFI stub and for the startup code in the arm64 port. This ensures
> that startup code can only call other startup code, unless a special
> symbol alias is emitted that exposes a non-startup routine to the
> startup code.
> 
> This is somewhat intrusive, as there are many data objects that are
> referenced both by startup code and by ordinary code, and an alias needs
> to be emitted for each of those. If startup code references anything
> that has not been made available to it explicitly, a build time link
> error will occur.
> 
> This ultimately allows the .head.text section to be dropped entirely, as
> it no longer has a special significance. Instead, code that only
> executes at boot is emitted into .init.text as it should.
> 
> The majority of changes is around early SEV code. The main issue is that
> its use of GHCB pages and SVSM calling areas in code that may run from
> both the 1:1 mapping and the kernel virtual mapping is problematic as it
> relies on __pa() to perform VA to PA translations, which are ambiguous
> in this context. Also, __pa() pulls in non-trivial instrumented code
> when CONFIG_DEBUG_VIRTUAL=y and so it is better to avoid VA to PA
> translations altogether in the startup code.
> 
> Changes since v4:
> - Incorporate feedback from Tom, and add a couple of RBs
> - Drop patch that moved the MSR save/restore out of the early page state
>   change helper - this is less efficient but likely negligible in
>   practice
> - Drop patch that unified the SEV-SNP hypervisor feature check, which
>   was identified by Nikunj as the one breaking SEV-SNP boot.
> 
> Changes since RFT/v3:
> - Rebase onto tip/master
> - Incorporate Borislav's feedback on v3
> - Switch to objtool to check for absolute references in startup code
> - Remap inittext R-X when running on EFI implementations that require
>   strict R-X/RW- separation
> - Include a kbuild fix to incorporate arch/x86/boot/startup/ in the
>   right manner
> - For now, omit the LA57 changes that remove the problematic early
>   5-level paging checks. We can revisit this once there is agreement on
>   the approach. 
> 
> Changes since RFT/v2:
> - Rebase onto tip/x86/boot and drop the patches from the previous
>   revision that have been applied in the meantime.
> - Omit the pgtable_l5_enabled() changes for now, and just expose PIC
>   aliases for the variables in question - this can be sorted later.
> - Don't use the boot SVSM calling area in snp_kexec_finish(), but pass
>   down the correct per-CPU one to the early page state API.
> - Rename arch/x86/coco/sev/sev-noinstr.o to arch/x86/coco/sev/noinstr.o
> - Further reduce the amount of SEV code that needs to be constructed in
>   a special way.
> 
> Change since RFC/v1:
> - Include a major disentanglement/refactor of the SEV-SNP startup code,
>   so that only code that really needs to run from the 1:1 mapping is
>   included in the startup/ code
> 
> - Incorporate some early notes from Ingo
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Kevin Loughlin <kevinloughlin@google.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Nikunj A Dadhania <nikunj@amd.com>
> 
> [0] https://lore.kernel.org/all/CAHk-=wj7k9nvJn6cpa3-5Ciwn2RGyE605BMkjWE4MqnvC9E92A@mail.gmail.com/
> 
> Ard Biesheuvel (22):
>   x86/sev: Separate MSR and GHCB based snp_cpuid() via a callback
>   x86/sev: Use MSR protocol for remapping SVSM calling area
>   x86/sev: Use MSR protocol only for early SVSM PVALIDATE call
>   x86/sev: Run RMPADJUST on SVSM calling area page to test VMPL
>   x86/sev: Move GHCB page based HV communication out of startup code
>   x86/sev: Avoid global variable to store virtual address of SVSM area
>   x86/sev: Share implementation of MSR-based page state change
>   x86/sev: Pass SVSM calling area down to early page state change API
>   x86/sev: Use boot SVSM CA for all startup and init code
>   x86/boot: Drop redundant RMPADJUST in SEV SVSM presence check
>   x86/boot: Provide PIC aliases for 5-level paging related constants
>   x86/sev: Provide PIC aliases for SEV related data objects
>   x86/sev: Move __sev_[get|put]_ghcb() into separate noinstr object
>   x86/sev: Export startup routines for later use
>   objtool: Add action to check for absence of absolute relocations
>   x86/boot: Check startup code for absence of absolute relocations
>   x86/boot: Revert "Reject absolute references in .head.text"
>   x86/kbuild: Incorporate boot/startup/ via Kbuild makefile
>   x86/boot: Create a confined code area for startup code
>   efistub/x86: Remap inittext read-execute when needed
>   x86/boot: Move startup code out of __head section
>   x86/boot: Get rid of the .head.text section
> 
>  arch/x86/Kbuild                            |   2 +
>  arch/x86/Makefile                          |   1 -
>  arch/x86/boot/compressed/Makefile          |   2 +-
>  arch/x86/boot/compressed/misc.c            |   2 +
>  arch/x86/boot/compressed/sev-handle-vc.c   |   3 +
>  arch/x86/boot/compressed/sev.c             | 108 +------
>  arch/x86/boot/startup/Makefile             |  22 ++
>  arch/x86/boot/startup/exports.h            |  14 +
>  arch/x86/boot/startup/gdt_idt.c            |   4 +-
>  arch/x86/boot/startup/map_kernel.c         |   4 +-
>  arch/x86/boot/startup/sev-shared.c         | 317 ++++++--------------
>  arch/x86/boot/startup/sev-startup.c        | 196 ++----------
>  arch/x86/boot/startup/sme.c                |  27 +-
>  arch/x86/coco/sev/Makefile                 |   6 +-
>  arch/x86/coco/sev/core.c                   | 169 ++++++++---
>  arch/x86/coco/sev/{sev-nmi.c => noinstr.c} |  74 +++++
>  arch/x86/coco/sev/vc-handle.c              |   2 +
>  arch/x86/coco/sev/vc-shared.c              | 143 ++++++++-
>  arch/x86/include/asm/boot.h                |   2 +
>  arch/x86/include/asm/init.h                |   6 -
>  arch/x86/include/asm/setup.h               |   1 +
>  arch/x86/include/asm/sev-internal.h        |  27 +-
>  arch/x86/include/asm/sev.h                 |  17 +-
>  arch/x86/kernel/head64.c                   |   5 +-
>  arch/x86/kernel/head_32.S                  |   2 +-
>  arch/x86/kernel/head_64.S                  |  10 +-
>  arch/x86/kernel/vmlinux.lds.S              |   9 +-
>  arch/x86/mm/mem_encrypt_amd.c              |   6 -
>  arch/x86/mm/mem_encrypt_boot.S             |   6 +-
>  arch/x86/platform/pvh/head.S               |   2 +-
>  arch/x86/tools/relocs.c                    |   8 +-
>  drivers/firmware/efi/libstub/x86-stub.c    |   4 +-
>  tools/objtool/builtin-check.c              |   2 +
>  tools/objtool/check.c                      |  39 ++-
>  tools/objtool/include/objtool/builtin.h    |   1 +
>  35 files changed, 620 insertions(+), 623 deletions(-)
>  create mode 100644 arch/x86/boot/startup/exports.h
>  rename arch/x86/coco/sev/{sev-nmi.c => noinstr.c} (61%)
> 

