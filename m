Return-Path: <linux-efi+bounces-6125-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKYBID0aj2lsIwEAu9opvQ
	(envelope-from <linux-efi+bounces-6125-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 13:34:05 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B78481360FD
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 13:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 516293007F4A
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 12:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F00015CD7E;
	Fri, 13 Feb 2026 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=edgeless.systems header.i=@edgeless.systems header.b="UJ6ze7cn"
X-Original-To: linux-efi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023087.outbound.protection.outlook.com [40.107.162.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD886334;
	Fri, 13 Feb 2026 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770986042; cv=fail; b=ZzvzJyULLaJF4D5sn8KoO7ElZEQP0yt6ccGauFhhHxBhwNnn9d9jVe4WspSUsjQakaucO0RSpoCsDYOPliORw4ojDT/1VvMC1a/8rF8aGofYYDu4KZr36O6nks+weJgfr/Vdy/hGXoc51emb8qCV1kAXtfPHMm5QxcR4Qb7vqvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770986042; c=relaxed/simple;
	bh=2Ow8KFgif1GuFK7hX5Hh33WqRWgmL230DMTqhgK4ldM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZtfxAZE93qtAeCVGs9RpkQCztDnTbKju1dSjjNpxyzS9eDm1DoS5v5yOrbyU2XY+F705q3DJgzlpTw7cZvjEPXwgY3ie6LRkh5xPsq3ERDluA/y95bWyYl1AN2JrEp02iWjnT9WPCEvo4syuzU80orIB3qN2C2Y4AWWg56XuXtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=edgeless.systems; spf=pass smtp.mailfrom=edgeless.systems; dkim=pass (1024-bit key) header.d=edgeless.systems header.i=@edgeless.systems header.b=UJ6ze7cn; arc=fail smtp.client-ip=40.107.162.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=edgeless.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edgeless.systems
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHvQCXPhafOwyTt4blmPvF8MJuhPchiIoa70XRnW388c8Fj0ZCk2FIe+cMsfJqOFfwlfOVenyL7/ZIWUwaATwAI0XTwYatLL5hwsJYCm+2ObEhM9TYJXgzGaEbdD4tOEy6kZmxI8hLX8fYy8tttb9cBbtmSlBiTrZz6/qHRXKbcLSoMfV/rmanmu3wKxTBGldiVVtzrnQqOYdDicjmxrm8GIud74IvkzJYeosYg5elcF3vB3k/L1gC+7vt1eIKPFcVAIkt/LrnSBLmnH1zL0+SZZBpMJ+5TLsTRP03eP9yp1sDfzd9dNihvuwY0amZ8HReSqnPLStQIZ22KTQzPVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtkVOVF7b8005+AScHu32BHMdG8xCCz/y2KAlMG9i3s=;
 b=bY1XZaTncdUgAfOvtoWPi+2eLhd/TE7RPPTUl7beU2mtFQojHKKkCvYSpvmnPwYZS3uLgrp0SmdOSuq6ZsbZWzu8cZJEjrTfG3JAlrvpHGk959/hy17U8ffgXh77lW2a3U97WCll7Uc3T/o8PQ1gJ7LGuCjxOneAO0xksm6dF4dd8t8/4E+S5lJDbZ11I5UCoEUTrP3VSxbyIuQlD4mJ/IXn/BX9VWGzgiNPVachPECOmZfWEK67/FZVt16be+Yhtwm6b/i1whz9CMNqrt6HcVmmbnvzaUI1e7bX71uARNe+GwGvB8mbGMcjfylPHx3wDwGBd6PAreNylm2bKdC+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=edgeless.systems; dmarc=pass action=none
 header.from=edgeless.systems; dkim=pass header.d=edgeless.systems; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edgeless.systems;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtkVOVF7b8005+AScHu32BHMdG8xCCz/y2KAlMG9i3s=;
 b=UJ6ze7cnBh2bSDCeOz2YRaRjFQdxo4qvjp4zN+LjlY6d0wcv253Jej1oeICpQ/4dHl30IDvd392tuu4u3lLnrWfbXSXwdffpmypJ9I3jyCR/IsgwtD/albPa+VUl+D87c55uhDMhMDhXsp2v1koigYyiM1l/sdvevQQwt8fFnxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=edgeless.systems;
Received: from AS8PR02MB9459.eurprd02.prod.outlook.com (2603:10a6:20b:5a3::12)
 by AM7PR02MB6322.eurprd02.prod.outlook.com (2603:10a6:20b:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 13 Feb
 2026 12:33:57 +0000
Received: from AS8PR02MB9459.eurprd02.prod.outlook.com
 ([fe80::815f:fa6d:197c:2470]) by AS8PR02MB9459.eurprd02.prod.outlook.com
 ([fe80::815f:fa6d:197c:2470%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 12:33:57 +0000
Message-ID: <5a0fa6d2-f138-4360-bf02-5478eda4b495@edgeless.systems>
Date: Fri, 13 Feb 2026 13:33:56 +0100
User-Agent: Mozilla Thunderbird
From: Moritz Sanft <ms@edgeless.systems>
Subject: Re: [BUG] Fault during memory acceptance for TDX VMs with certain
 memory sizes
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, ardb@kernel.org,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Weiny, Ira" <ira.weiny@intel.com>, "Wunner, Lukas"
 <lukas.wunner@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c2632da9-745d-46d8-901a-604008a14ac4@edgeless.systems>
 <b6f00f31-ab39-4a76-b758-b3cfb1b0dfbe@intel.com>
 <cf37b7df-1265-411c-8aac-f82c3732fde9@edgeless.systems>
 <aY8Quu2WJG5HB3PP@thinkstation>
Content-Language: en-US
In-Reply-To: <aY8Quu2WJG5HB3PP@thinkstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0026.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::9) To AS8PR02MB9459.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a3::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9459:EE_|AM7PR02MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 03867fd6-6bb5-4b81-246e-08de6afc283a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUovVEN6Um1ZQ2VSYzIxRk8wQzFUVHE5NTlDS1RjTHJPSVNwMWpHejZuTmFa?=
 =?utf-8?B?Wm9rRGpZYmEzWkh2dzJqUkVQdGIrSDZVaGNtN00ybkNjNU1JZUdKcXpCdm5L?=
 =?utf-8?B?UTl1cGp0YWdXNGpuc0ZPc1pzQ3d5NW5jN1dpcjdJTnI3UlpUM1UzVVhVenht?=
 =?utf-8?B?WVlZVzhhZE1NeVRPM1kyQ1lXWm5uYUdLTzRhUEIwRW5lS2xSTFRhUHZzeGVj?=
 =?utf-8?B?emFUL01EVStWVWU1MDBRTDRuMEx0VXZNRTJ2aldvOWp5OFNub0lOa2ptcFUz?=
 =?utf-8?B?Yy9LMFlmMmRKRTlHWUFiTk5GUkwwSUV2SFZRdGVCQlQwelJiRzBjVVFuVkxL?=
 =?utf-8?B?bFExL2ZIbjNaZHJDL1BUeS9hMUxoRWduQlJIRVFEU2RBTnVGeFY2bzUrMDht?=
 =?utf-8?B?K3o0ZzZaSVNLcXZJWEpyblV5SVVVRGhlRUtuY05ZYlBBK2NOWDQzWDZZS1lt?=
 =?utf-8?B?cWgvVVJYZXRHNlJxVnAzN0RoVmdDUk1MNitYaUxpVWEycDN6V2V5Wi9aUzZO?=
 =?utf-8?B?Y0hDR2NwdW1jdGk0V0N4ajczWUxOU01NbFkvdFVZQVpWMW81YkFCc0xOVklZ?=
 =?utf-8?B?K1Z3NllXVGREYkJPNGIrN25YU0pydTJoU1AzYWlJckxQeWZmblg2eGtoeW5j?=
 =?utf-8?B?N1FBeWlBODVWemw2Qm9SRzFHVU95R0MwTjMwSjV1RGZvRFFXM3BpNWRobmww?=
 =?utf-8?B?eFJJdVMzUENPOHhEZUx3Q1JnYWNibThpNW50QnpLSHE1endvMTJHRzNvSE1N?=
 =?utf-8?B?aklDWUkzQVVSRmJPOE1tSVM4a3hGNVFoN1FucGY4QUlzRC9HQlFQN3BLOFhy?=
 =?utf-8?B?ekFkc0lBMCtnZTdwb0phRktwTEJESnBqZXNEeG5QVlJXM2M4Y3VKMVdtak1k?=
 =?utf-8?B?K1p3blRSWmNqR0xONGk4d2tzRmRHWGd6OU9XSzlMMnlTR2VRYU5ZZXBDNFJ2?=
 =?utf-8?B?d25JNVlBckY4cWtNL0t3d3c5VWs4N2hsZ0ZtYmJESmZ1eUhIQ1daOWE2Zys3?=
 =?utf-8?B?dis3WnpZR01LcnA0bXE4WlhrVGJLTnZOV1doTUFjcmNjVHpiYTJUTmFqM3Fj?=
 =?utf-8?B?bFcrMklodG5sb1hneFNYUTNxRHd5VytpMGVwVFJhR0tuRmJLNm45dmFibjg1?=
 =?utf-8?B?ZVFPVzg3aENxZVF3N3JjTkpNMUJyMXdoL0E5WnlvdlljbFBWOWRZdzNyM1g4?=
 =?utf-8?B?b3p1c2pPWVo3K2syQ2MrcFE2a2JOWkpwRHloMFY0ZzQxOUtsU0VKRnpZb2lk?=
 =?utf-8?B?ckhyTnpNbnNWVmVZWHVyNmtTczRCcE5jdm03cytOR1BLR0xpR2p3bDh4OUxx?=
 =?utf-8?B?cCtmWTNPKzNiekNhdmRDQUZYejBlclFGQi93bDZ1NGo1aVE4RCtSTzhITGJh?=
 =?utf-8?B?NUxYWnpVQXF5YWR4SFZ1UzBVT052RCtWS204dU5qZXdBcWhFOHQ3dUlVWnVF?=
 =?utf-8?B?MTE1SEYveFRDVGV5RFREc2lmcWR0QklDYjdvamRrdDZZOW5VQXNxVGlYbHJ6?=
 =?utf-8?B?WnVKWW5PeFNXa05VMmZSMkJHYkhackNpZkViTU53VjR1dEVsSE8zNE0zaHlF?=
 =?utf-8?B?WFUrTmtJNW00RVZ4YS9Uejc0VDJaYUU0NXU3Wmg4ak05OUJRRjUrK3U0aTEr?=
 =?utf-8?B?MHRLZndnVmdacW55TUZzRlF0VmNwL2t3ZGFnR1RaMmp6eVE3NXB3NWZNODMx?=
 =?utf-8?B?NU9Yblk2bnhjZDVoK1J6bC9EWVlWSy9XWGxXdkFRRlQzMGxTMWE1N25XY21K?=
 =?utf-8?B?RitrTUFDRUpTQjJOZzJIZk5DWTBmZ2NaUkpqaXg4aHFxNTFaU0dUR3c1Uy9Z?=
 =?utf-8?B?UGtwRzNNUlc5ZGJibzlUaDE0dzQvTkRBN1ltbHJTOGxSOHRqVXAwTDlEaUhM?=
 =?utf-8?B?aU9PRXNFRW9XZGh4bWRiMVJnREZUVUVqbWNEUHVKQ1J6RjRHd1hqMVZ3Y1Zu?=
 =?utf-8?B?UDIycmVKYmFRMzNMSFpSSjZ5a2tHZm1tQ1BqbFZrdHBnTGF6emRXWVhKVmJH?=
 =?utf-8?B?ZGovY0JWRk8zVG9IYmFrOFF0Z2lzYldUTVF0eStubGExaXFKKzljbTJjeERG?=
 =?utf-8?Q?4/OVfL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9459.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkN2MUZUSWVrRThKaFZsY29HQ2JnekdJWVNGRENNUDN3azczN1p6Yk5tbmR1?=
 =?utf-8?B?SStncGE2QmVCeFFjS2hwTHVQaDBIODZoSnlveERPeElkYWQyOFJ1K0VMMlFo?=
 =?utf-8?B?ajMyWFp2NVY0REZDTEFtM1NEdDJ2ampFRlpGejVtbVVEU1Fsb1ZKYWtQak9G?=
 =?utf-8?B?cnlOU2tZUGZMNW5LcGR0Zi9wb0xTYzlLYjBnbXl4a003QkJBSENVQitTanZM?=
 =?utf-8?B?WHpuem9YckE3WlIveVNJVk9PcW9pQzhPVC9CWlF0Ujg5cC9BelpoeDdrSWtQ?=
 =?utf-8?B?VmpxN0Ewc3F2U25hc0ZCMHIyV01QMk9aOWhWczllYVhReDVLTU5jc0F3QTJC?=
 =?utf-8?B?M0dGQVd2SHRlNXlPbmllUUhQRHFiZGhrbk02R1pzWVNYMU4xNjVDajQ4MW9T?=
 =?utf-8?B?c3JBOURNNU1ScVMvMHRTL3k4SlRBd0xtK1QrbzhnZ3BXbVVKbTJmZFoxcURr?=
 =?utf-8?B?MHdpczFJOTJDbzhtVzVFbFczWVFXWCtNSzJlZjNBSTNSdDZKOVNNVmEzdmVT?=
 =?utf-8?B?ZElBWmNKeGpXdU5oQ1VvTi82T3BvOTR4YUREai9idmZGSWpBSDdTNFY4akJ2?=
 =?utf-8?B?TVUwM3dKczFUc2ZYeGJHc3ZPZ1Judk42TzhOZHNsaHRaM3dnZC9BeFpiWWF4?=
 =?utf-8?B?NjZYMzVZYUhGTEhYY1k2Y0Fvc1Z6c1FFT2xwK0U3ZWJjQlp3V1JHcE1uMGxI?=
 =?utf-8?B?MktuWVdwRndNemtrdjl6bjF4aDJtMmxKZVJXeXh6VGhPdXQyeGl5bklITTY0?=
 =?utf-8?B?b2pwb3ROWVdYYmlhNnVEdUFKVE9PbEEvVTdSL0tGVXAxK0NHa20rWjRVQTl0?=
 =?utf-8?B?OWxUSWJaSmVXZWluMGRJemloVUp1THloeUlVWFBzckp5OW9jdFE0N0V3dktJ?=
 =?utf-8?B?SUpmdmtjU2RtaE5FTXdQanlxa2dLbVYzSEM5RmtXVHowRXozcndaM3o3Rnc3?=
 =?utf-8?B?VlpXRnpXRytRR2hxa1JkdjNmVXVOZlpsTE93RDJwM3lmNnNrWkZCVTNyTTEx?=
 =?utf-8?B?WFI4K1o5dE5PZXh1eFBaQkw3VTA0ZTl6Uk5iMVRnVktZdkVpK29zVzI3UGZK?=
 =?utf-8?B?ZWhtNUpIYmFDL0hJazhVR1RwUEJaWjhzKzNsbS9ZVDFDa2kvd0hYY3YxN0hI?=
 =?utf-8?B?d0syOGVRS3MybVIwQlFjL25odTRHOHpvL1hmUmQxY2drYnY5Q1hHcnZoclZx?=
 =?utf-8?B?L3FDMDdxazZIUVkyK1VJZjZQVFFCbFpVMWVzSHlka1FVUHIvT2QxTWVNZklK?=
 =?utf-8?B?SXNma1ZBbmlKSUZpQjArc3VZakdTNWRCWGhqcUVqTWZBOUJManBQaGFPZ0pv?=
 =?utf-8?B?eDJCMkNKVmhwVzhjYjV6dktVZEYvazBpY2tmN3F1L21ZSGxZNitmOExrQzBx?=
 =?utf-8?B?NS9zK0Nua3dRTWZ2TTVCT2FVZEFJdW9sTG5rWitPSXE0ZWdacjhPUTB2eTNR?=
 =?utf-8?B?azFzY0NrZlo4ZEpIcmVqZkdYdTBvOGpML21oZHhZU1NoQUhPVHlkUWhmeVZY?=
 =?utf-8?B?SUQ1cndwSi8ybXE0ZGthd2hnZWIvTEZFL0RmbGxVck55M3ZOUXhqOTFMcjFJ?=
 =?utf-8?B?OXRiQVJ4bG1YNitNaENIYzVWVzdXT3U4QkxKRHpvT2VEaDNaMDVSamExWWkx?=
 =?utf-8?B?L3Q3SldpaFNPdXp0ekZRTlc2RlpqRkdNRUhxVEFnOWpqM2VYakVtQm5COUhE?=
 =?utf-8?B?NmJ1d0hjaU1qbmhFZFltTis5aU9GVG5pMFl2TlZTMHdoUldXditNeFhXRHE0?=
 =?utf-8?B?WDVkcEgrSlowRWowYTBQOWxmbk9QOE5CL2NvdE9iZ3pUVE1wVVhNR2Y2Vk9X?=
 =?utf-8?B?SndlMThvbDN0MU1aVng4b2FXSDY5QzE4VjNhWEVIcnRrT0JORWZCRkE3bzRw?=
 =?utf-8?B?YkdIc1kzQVJQcDRkMDQ3cGRtOERvNWtSTlgvUjM4Q1FWWlI2dE9hT1VYQ0lq?=
 =?utf-8?B?UkgvbHBBN3RRZk1ja0VhV1VhclcwV3lLL2VBVG4yb0xvOHhqMHZLcENKUndC?=
 =?utf-8?B?am5PeStCNlBScjFUWDJzS0ZrRlhZZUV1a1RyaGdrWXBlWWRwdHhxV1NKdEha?=
 =?utf-8?B?U2tnQ1dJajBoUjJUeGY4NVUwVEo0MFk0OUZnVW5qazNESk1QKzZ4WEhhOU9s?=
 =?utf-8?B?YjlYUHNSVXNOZ3Q3eGlrRkIvdm55TmkwYWR6c1Y5d1d2MUhzT2p6YnFsMGJ6?=
 =?utf-8?B?eXhhbURVeXNpYUQrcVZTRHRGOEZWaTRiYVVEc21LZDRhaXl4UytpbSt4OS95?=
 =?utf-8?B?QUkvZWlFK2dtVzZoMlFtUUJ3K2pucTl4UG9TbG9QZjRCM3JOVjlpRHNQdnFj?=
 =?utf-8?B?MkNpcGs4U3pvV3pVTjZabitQNWRLazhTTmgwMjdad2IrdnI5TU9aZz09?=
X-OriginatorOrg: edgeless.systems
X-MS-Exchange-CrossTenant-Network-Message-Id: 03867fd6-6bb5-4b81-246e-08de6afc283a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9459.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 12:33:57.3814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: adb650a8-5da3-4b15-b4b0-3daf65ff7626
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEdGrKIjf1+9QUie5PBdrjwKlQVZwhWSHeUjfiz/l/jUNsvceE+EmTstlxz+XaxTxDGqp8qvLlju3QhhL2uN2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6322
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[edgeless.systems,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[edgeless.systems:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-efi];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,edgeless.systems:mid,edgeless.systems:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ms@edgeless.systems,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-6125-lists,linux-efi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[edgeless.systems:+]
X-Rspamd-Queue-Id: B78481360FD
X-Rspamd-Action: no action

> Could you check it this patch makes a difference:
> 
> diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> index c2c067eff634..f2a00cd429f2 100644
> --- a/drivers/firmware/efi/unaccepted_memory.c
> +++ b/drivers/firmware/efi/unaccepted_memory.c
> @@ -35,7 +35,7 @@ void accept_memory(phys_addr_t start, unsigned long size)
>  	struct efi_unaccepted_memory *unaccepted;
>  	unsigned long range_start, range_end;
>  	struct accept_range range, *entry;
> -	phys_addr_t end = start + size;
> +	phys_addr_t end = start + PAGE_ALIGN(size);
>  	unsigned long flags;
>  	u64 unit_size;

Thanks, I tried this on the `-m 67000M` VM and the crash still occurs. I 
extended the previously-added logging to also log the values for `start 
+ size` and `start + PAGE_ALIGN(size)`. Please find the full patch 
including the logging and your change in [1].

The produced logs are as follows:

```
[    0.046472] accept_memory(start=0x00000010db600000 size=0x200000)
[    0.048747]   unaccepted: version=1 unit_size=2097152 
phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
[    0.052557]   (start + size)=0x00000010db800000 (start + 
PAGE_ALIGN(size))=0x00000010db800000
[    0.065217]   bitmap_clear(bitmap=ff1100007d624030, start=32475, len=1)
[    0.067928] accept_memory(start=0x00000010db7ff000 size=0x1000)
[    0.070167]   unaccepted: version=1 unit_size=2097152 
phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
[    0.073917]   (start + size)=0x00000010db800000 (start + 
PAGE_ALIGN(size))=0x00000010db800000
[    0.077150] accept_memory(start=0x00000010db7fe000 size=0x1000)
[    0.079365]   unaccepted: version=1 unit_size=2097152 
phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
[    0.083080]   (start + size)=0x00000010db7ff000 (start + 
PAGE_ALIGN(size))=0x00000010db7ff000
[    0.087123] accept_memory(start=0x00000010db7fd000 size=0x1000)
[    0.089362]   unaccepted: version=1 unit_size=2097152 
phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
[    0.093239]   (start + size)=0x00000010db7fe000 (start + 
PAGE_ALIGN(size))=0x00000010db7fe000
// unrelated
[    0.150522] APIC: Switched APIC routing to: cluster x2apic
[    0.152595] accept_memory(start=0x00000010db7fcf40 size=0x83)
[    0.154745]   unaccepted: version=1 unit_size=2097152 
phys_base=0x100000000 size=0xfdc bitmap=ff1100007d624030
[    0.158479]   (start + size)=0x00000010db7fcfc3 (start + 
PAGE_ALIGN(size))=0x00000010db7fdf40
[    0.161713] BUG: unable to handle page fault for address: 
ff1100007d625008
```

[1]: https://gist.github.com/msanft/d6d7e32a65708f5bd36233649e4facee



