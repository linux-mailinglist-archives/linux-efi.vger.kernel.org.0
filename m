Return-Path: <linux-efi+bounces-4549-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 663D4B25534
	for <lists+linux-efi@lfdr.de>; Wed, 13 Aug 2025 23:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947241C84493
	for <lists+linux-efi@lfdr.de>; Wed, 13 Aug 2025 21:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017E230E826;
	Wed, 13 Aug 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="m85RwR07"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2110.outbound.protection.outlook.com [40.107.237.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1530AACA;
	Wed, 13 Aug 2025 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119992; cv=fail; b=tPQRjlLgnm867XCgI7ksR0qQhk5obcZX+2Zg3pqTLXkw+ROxhm/HcqRfE1buUZnyaR00bb3a1pU6SbtNu/cTnEiveVuqOkIBOH7LQsoOaIqge8iFMKdd6Jnr5D2aKKDPpdsHC4w8UmeCVr5blZbB78YVqurHbvBAULc54nhsXx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119992; c=relaxed/simple;
	bh=VWmmZySvsC0NkQY8VVXYlfvIiROA6vS4HSNzWwgHstY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZTuqxLj34opSYWgJkRg1jatmgCO1oqV+saJGWYdaubG2+kVHjST23+eht2db3hu7tCgGk7mt7aE3nzpwmGMByEwtMmCiIE39JO2i/hczY4Jn9+r3l8PUmHbfRbnVHWLE2RmY21aZdZFSnvsbTbLYTYayKD1vjKQhnAcFfE0voBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=m85RwR07; arc=fail smtp.client-ip=40.107.237.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHh/uFAUottzDkMXCTas9eXHDgB8xiugisJYd8uygrJWACbIe12qyR4E+1hyKK8xb+qHEDODVoPf7/Sf+Be9wu9gY8pOOs8h4g3MqGO/YQAOBYPvesWtyRCMUrfj+vkQldxyHu88etWxFQUnuP1+cgA3tJdV8RF6qXL8DnvNztWYprJPoTxpnBaxwunlN/TyqUSUj68O73pLaun4n2/Slx7usj6fQhh1LdGw5T1gIFSzCCLKz1u63FlUO2arEOggUbWMYr2HpwQQjFDD5jDBlR36gx6r1Vzb1kxhUPP9Lm4uxI4IkRQSJU8QV6/edi+iaQhg3OKds2UpwQ7kARaysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ONZ6VMxeM/i9fNQr6Ks14ia8iihRqfgfE9CGNxrxYY=;
 b=mFoLQNYet3eZ5Lo9Df8MlkOOabEBEg0PSz6CYjDX/7JD/Bpli5Dk4nTyV2ZLfEjx9gFn5hBnYiglafcqHj4sQjP/mh3qxMhEIfA1EvQNF2LPuSBjZ2bhoLWRoV8jaJjUxhNGEzVp2KLZtJDomfT+7q1rNLl0UZg/ehjtPBPtb423BYG4+MKfG47yZSRYD21H2ZTLgEkz0Zq+OSxm+mUdrDe0uOHJ53f+VSzQvvovXOHxNjaoDzz4+Uu4Tj/a3mZQhJ/R5BF+DtyzLdQ40yt5U6Y3VhLvZHGsLgkLkQBEwSyH2bGLtrnNG9ATYL7Ezou0WAKPOMuBgg2qv4DdSFUrrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ONZ6VMxeM/i9fNQr6Ks14ia8iihRqfgfE9CGNxrxYY=;
 b=m85RwR07PWP33PSwegm7AIdrz+4DGOk4W9KC0O+NW9308ryNcUe7d0wt2b2M02+lM9DIVknAtDAqYJmQ6TlBNQHyQ+GOrEzVDRXqmqD4lA4bZ41Rk5YAEYaqf1GHZEJ6uc0ytWsKGMdO1rJHsCIzBdEzSK++0WJf2+rDQvXvbJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 DS2PR01MB9390.prod.exchangelabs.com (2603:10b6:8:270::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Wed, 13 Aug 2025 21:19:48 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 21:19:48 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Wed, 13 Aug 2025 14:19:18 -0700
Subject: [PATCH v5 5/5] docs: efi: add CPER functions to driver-api
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-mauro_v3-v6-16-rev2-v5-5-954db8ccfbe6@os.amperecomputing.com>
References: <20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com>
In-Reply-To: <20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-edac@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: CYZPR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:930:8f::22) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|DS2PR01MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c936d6-e2ce-4ee1-e53d-08dddaaf2221
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTFLdG51M2dSMGNMK1pEak1DWkc2WjFzZElNL0xhblphTlpxNGFUTUJCQ1px?=
 =?utf-8?B?QlFVVDI5MFlkb3FDaFFydm1sRFlkVlQ5RndONGh3dStCTXFiSWhJR1Y5dTJ1?=
 =?utf-8?B?YUJJMElWMW91bW14ZVlBMXJuM0hnVDRzd2tVeERRcFl6WWZwWiszaS92bFVF?=
 =?utf-8?B?TldJQ0RMUm1DeGV2SndPWWZMYlBKbG1Da1NkQ1NJSG1qcitGQWhhZ0o4SDIv?=
 =?utf-8?B?LzlnaDhES1hxdjRKckk2Mk1lRGJpVDNFb1U1dWR1bFJhN0NzaGVyVGpzSnZX?=
 =?utf-8?B?YmU1cDRuV3V5c1YxZStjT2l6VEFkWXFEVDNhUkVrTEdBSEMyM1h5YWVpdWFx?=
 =?utf-8?B?eWFpejRTWXlwTlE2SVlpVHZlek1KaUF6aitwcFFJa2ZPSTBoQk5pbFZFTkEy?=
 =?utf-8?B?UjJwTHBFdHNWbEZyd2NVUWt6QW11UW5LZS9KV2dyT1ZpenpRT1grRGF2eE1i?=
 =?utf-8?B?Z00zS0hQZmdHRTEvNEs4TGFaWXVxTytselV1UkRYRnliOFEwdDJNU0xWdXRL?=
 =?utf-8?B?MTdrRTVCa1ZQQWdVZTl3TnhIM1llK21CVVdzbHIya0IydVlvSmpZcFBzVmdU?=
 =?utf-8?B?RTRyMXZxa3F5WnJyK0VBZmptcUNzdHMyT3FMTnIyUWlvYTVwTW82YnltbTlG?=
 =?utf-8?B?ekdEWlUxcmlQVEVuTHQ3anR6STBoZ0hLSWV3bTJ2QUd3TWhxbTA3MGZsaFJv?=
 =?utf-8?B?bXVIRDlzRjhjN2ZVUTJZeVdKQXlDcVZlaDJza3llUG9UU201L05OV2hFNjEr?=
 =?utf-8?B?UXVvNVlvZHN2bHNTVEVJb0dReitFVkIwMzFBMklsRVlTSGx5ZjkrZDdsSmph?=
 =?utf-8?B?cG9lVHFtdzcvbEhhUldTN1hkOHJxeGhPbXJCYXlKMTRIUUl6LzUrb2Y1YWRa?=
 =?utf-8?B?aEZCbCtwRnJaWnRyU3hhK1dBU2NnMVBmSUVmQlp0VGpsZHErRXBaajZDWnFG?=
 =?utf-8?B?ZW5mMjZFVjBQb0c5Nm80MkllaFRvTm5CeitpUG1qM0l0NHBkTU4rQytpUEk2?=
 =?utf-8?B?MDNHRG16c2x3bHhTUVZzcGhHYlJxRVlxY1l6d2xUMDZvdy9tKy9SVGhRNkxp?=
 =?utf-8?B?VkdqcXZ0Tmw0akdSOURPc0tRd0dqMFdobjU5aVpOaEhMR25LUDVjeFQvZHJx?=
 =?utf-8?B?QVA0WTRlRm5qL05kNnpkS2ttdVJERjJUWU1QU1lFTEVLSXhweGVTdzNiSDhM?=
 =?utf-8?B?VTJvbHVrWU0rZUg4ZkNLbC95Vlh6VFZyVk9JREkzTHZXcVR2ZkdqU29SL2Js?=
 =?utf-8?B?cEExTUovdyt4U0JkRkNQRHJqL1ZYVlN5MWRIamQ3UnQwRm9nWFFrK2FHUXdx?=
 =?utf-8?B?T084R2UwNkg2R3BsVVBGZTdrc3V0QnNPbUNLcGp0ejRvSkIyemFodjREb3gx?=
 =?utf-8?B?WVNja1pIRGJ5aU9COGI1VjZKVlhCSmI4aTFnTlMrRmZrOGpJZjk5RDliS3Nh?=
 =?utf-8?B?d24vMkoxMkNzYlNNS3lSTjRzK1FkMUZYNDdsOUsrdFRyc25VQnRzL3NDdlcw?=
 =?utf-8?B?bHVqaGd3aFdUVjRIQ3JsUnZHaE9zLzNyQzRxakY0NUFNeU1ZMklXYlgyY1Js?=
 =?utf-8?B?VXRvK0FhaVM0czNWZFNWU0d0NkUwdjJNRGUrU3A3cFZXcUdaVXBlUnJDRVFB?=
 =?utf-8?B?UlF3SzQrN0d4Y2hBYmRncUkwcUsrMytWN1o1clZtT0dCWjhQNnlKQUd0cExy?=
 =?utf-8?B?TXRqV2U1M2gxdFB4YUNUUyszNDlDTjBNZmRHY3lZdXdxYmg0dUVjeC95WEpm?=
 =?utf-8?B?bmo0eGREREFtZUR6QmdvM2xTMW5nQnF5TU5ab3RFeTlkaHpQM2dDOEd0bWha?=
 =?utf-8?B?V1V2R3JtRzdXVjVRS2ViWG5aQ3JDNnZSSjFacUxmWk9RVTk0dFhuVXJEVzd0?=
 =?utf-8?B?eVJGaHVHREN1YXhGbHVQM005MmY4cFJrVitXa2xqTDNzTVBKTGx5N3BOUGRX?=
 =?utf-8?B?blRvWWl6aHZJaHhQb1VJRlNEc09HUHFScTd5VHNZeFVzMzlhamd4dURKM1po?=
 =?utf-8?B?Rk9oTzBJUTVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emZBUTBNNmw2Znp0TkFwcmZqR1dMUnhIeHRFTko0ZGZGZVpDc3duQlZnd3Fu?=
 =?utf-8?B?VGdTYWR6c3hPYXVzejNBTHNyeitDK2VlaEUwOTNuSEcwa1VibkdjWjhueFZp?=
 =?utf-8?B?aTBXd0RsYVNuc2F6N2tKQ1hxckpSVi9LSmVLTFFMQnZES3VNdjErSXNNUGF3?=
 =?utf-8?B?YWNoWHIyQThjR09hMWIvQVdkS3BqMUkwaTNJd05QRWV1bXJhU0FSTUovblor?=
 =?utf-8?B?OUY3T3NpdFJDb3lCaHJJemZLQTltQy9ud1BCcnl0TGZvcGVaZkRoV2hIbGJj?=
 =?utf-8?B?ZTE0dFVYN05jN3ZKM29PdENOMVZOR3AvQWJtVGx0K1RPRDFKaWhxS0hVQU9l?=
 =?utf-8?B?Y2R2anNsdEo3RDkwK29FWlhUYWVERDM5eWo1TGp4NmZOSTloOFoxM1R1OFov?=
 =?utf-8?B?Sy84Znc0Mms1WFNVQVdNbnk0YUhOTWVmSy9JUm5ZY3c1aFhhaWRtMzJUeC9j?=
 =?utf-8?B?N01HbG9Mb0E0L2tRYzU4WStRYUNLd2Z4b0UwOFZGR1ZkVk5JMWd3Y2dtcHRy?=
 =?utf-8?B?TWxrMDk5aXBoVEZTWDJqSjBiMGUvZ1F0VFFMM0FIV0NKTTVlUlJWNDFsSTds?=
 =?utf-8?B?b29NYWhwNkw1NTBrMVVFakxieFcraXVRYkppRGZ6WjRIeTNHN2ZxQ1VFSFZn?=
 =?utf-8?B?MDIwNjJveW9NZEh6UUVrV2l6S2tOTENscXQ0VzhZM0FmWXhNQ2YvaG12Y3Vr?=
 =?utf-8?B?d0lIVVlzd2xsbURRSVMzekRsTGFqbklFTlNSUU5PbTBwZlo5eFN6Sm8zZ1dH?=
 =?utf-8?B?eUdlUVlWaW1wWDVBclFGT010TkpJTDFVTXhmSjJ2emhBVFdIdnltRnRiUW9D?=
 =?utf-8?B?YzYzOCt2NjRFcHA4L2ltYU5MeU04UGJFdldESGxKTkpxbzMrL0t0MEtodTBp?=
 =?utf-8?B?ZEFiRmhPSjJHb3djRHJzOFYyWTdteVdjTHB6MkRCcHNYUEo0TGZDYkU5TXcx?=
 =?utf-8?B?WHdpdHBJZGhQOWgwaXl0Sk1DdG5DUzBlamVsMDFZU0UrNTY3dk8zTGkwY2tC?=
 =?utf-8?B?cDEzVTIwS1ZBcVJsbExrUXpFTkxtSUtFK1hUNnZPUmhxR0tiTG9nai9xNDR1?=
 =?utf-8?B?Z3hYSkMraUN1T2tvMUxGYTZPUDRzZUgwU1FwWDdxUFJka0dleG1GeEtROHFn?=
 =?utf-8?B?YXo4ZjBXZ29oaFJvUTcxZ1hiVVBFb2lFWFlIaDVzNE9MYmJCVFJ5M0JCRXdD?=
 =?utf-8?B?TEV1WklBUjVNWkNhQ0tIaVFjWjlBaXVwOEFBK2NWQVp4WnJIZVdQMGsrK0VG?=
 =?utf-8?B?M21zMlN4czFEUDFLSnhiOXc2cW5zY2gwOFVWVDY1RFFZKzQyWWRSTUhIU1RN?=
 =?utf-8?B?UC8zc0p0Z08zSzZ3NHlqU1ZhUkdUVGc4ZU9Ja0NGazZ0N0NhTzBGenB3MnVZ?=
 =?utf-8?B?UFU0RDVYc3JKZHV0Q2F3SFZRQjRkbzB1c2UzVXpWc3dZVTBlUThKVm12RHpU?=
 =?utf-8?B?ZEV5OUlWUVpSQ3U4RzlUTWk2VCtqSndoRThITFFJTWg3V3ZieG85ZUx5SUJN?=
 =?utf-8?B?Y2RoREpJVEJaT0ZnNjdVSGN2dUFPQ0hjcDJrTWdtbHhhR2FUdFprR2ZxdlJF?=
 =?utf-8?B?UU54Tlh6b0F1NFZFTVgrV2ora0JkT2ROcEJpczE2TFdHY3dRejdQbklwVGdH?=
 =?utf-8?B?MVpDeUd2MHBEK2thZUN5d0JnaDFOdnJxVG55ZXNHNW80L0RRWWF2WlBJREtE?=
 =?utf-8?B?RlQ1U3BVUzg2dERmRXFlc25VdXlWR005TTBtVjhoUTVQWThLVlhOMy93SHg3?=
 =?utf-8?B?dVVQMU1nVHVHQmNraVUvRFdjTGFmSEdrSjF0Nm54VEUwa0phbjhtTnFrU2tn?=
 =?utf-8?B?Um9WT1VCMFM5Y245UWZTSHp6YjJLNzhFWUMvbXJTSldSN0dkWDg2b2tidXRD?=
 =?utf-8?B?eGdJUERPQ2F2ZExFRHhTN0JQc2VKSjlHVGFQOG9KdndtMCtGK2F6M2N1OUxS?=
 =?utf-8?B?REFwcm13OUlTZnltQlQ3MUI2UkpWcllsdzRNVUtSMVRPamsvV2EwRGFxZVBM?=
 =?utf-8?B?WUVaeW5BUTJrOHRJdjF5bVVSdklCQi9jOFEwampCMDNKKzF6TlcwbTdDdklN?=
 =?utf-8?B?djk2anRNNDJ4bXBsYi9NMUQ4WWtlNmNoMlhZT25vWVA5WmRlRWJ2dU9hMmNl?=
 =?utf-8?B?bTNVdnpaSkIyZ2tQQ2JERTRTVWRSVUxTck5XUmttSzdTVFhnanFDRVptbTc4?=
 =?utf-8?Q?D7xuZfH5qN82wv+kpMi9TWI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c936d6-e2ce-4ee1-e53d-08dddaaf2221
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 21:19:48.4823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Il0EY3EtxM6G+lPZGzkueoWIDs8Yv79uAzhRnmUcpWGN6kVDqd6zcajl6IUf8cYeHW+mXTsmplFGfSSa8dguwC7vTWMWqp3rTIynH3HlQpNByVVP8/0mM3XiXdC33wCT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9390

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

There are two kernel-doc like descriptions at cper, which is used
by other parts of cper and on ghes driver. They both have kernel-doc
like descriptions.

Change the tags for them to be actual kernel-doc tags and add them
to the driver-api documentaion at the UEFI section.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/driver-api/firmware/efi/index.rst | 11 ++++++++---
 drivers/firmware/efi/cper.c                     |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/firmware/efi/index.rst b/Documentation/driver-api/firmware/efi/index.rst
index 4fe8abba9fc6bf8ed53443e48e79285730871c32..5a6b6229592c9a9d1eb223966c582e0969ee9514 100644
--- a/Documentation/driver-api/firmware/efi/index.rst
+++ b/Documentation/driver-api/firmware/efi/index.rst
@@ -1,11 +1,16 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-============
-UEFI Support
-============
+====================================================
+Unified Extensible Firmware Interface (UEFI) Support
+====================================================
 
 UEFI stub library functions
 ===========================
 
 .. kernel-doc:: drivers/firmware/efi/libstub/mem.c
    :internal:
+
+UEFI Common Platform Error Record (CPER) functions
+==================================================
+
+.. kernel-doc:: drivers/firmware/efi/cper.c
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 79ba688a64f8da7af2dad097b9331c72afc73864..0232bd040f61c9b4521ae50ec4b6a1b0bfa5cc19 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -70,7 +70,7 @@ const char *cper_severity_str(unsigned int severity)
 }
 EXPORT_SYMBOL_GPL(cper_severity_str);
 
-/*
+/**
  * cper_print_bits - print strings for set bits
  * @pfx: prefix for each line, including log level and prefix string
  * @bits: bit mask

-- 
2.50.0


