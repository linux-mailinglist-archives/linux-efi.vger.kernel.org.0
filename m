Return-Path: <linux-efi+bounces-4514-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1B6B1BA45
	for <lists+linux-efi@lfdr.de>; Tue,  5 Aug 2025 20:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C50627DAD
	for <lists+linux-efi@lfdr.de>; Tue,  5 Aug 2025 18:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FCE29ACCE;
	Tue,  5 Aug 2025 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Z4wPEgnh"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2090.outbound.protection.outlook.com [40.107.236.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEAC29AAF0;
	Tue,  5 Aug 2025 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419026; cv=fail; b=eo89d9qnVA+4FTU22PkdOlXSJmejnkeaqCaCRMqskDssEjsU9Vj2y1JEgetAkLFZJYZqOh2V8u7HzaYFGvrZy/WsjgFmvHXgSLMNMy4wivJLK7/fGF9GnMMIlhDjjnosqziFWJ1s2l8mQvmbG0gOt24bkfIWwpH5ocWrpKY9ia8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419026; c=relaxed/simple;
	bh=zDOv53acVGC64ynUcU2gVBFwqcGl5ahdUoqwfCET71s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CBFsq84AVBR/yIEj6DkKieT7H61WL4qL1kFCwp0Wouq/3gztKMotH7QfDdZPwMk80EOaYjw6krZGIajeNFwA7I4eIaIdtQVaCwwVWFnEYUKpf8Wg5t395xk43n/IxBHdKmv3TOwovltK2ldDzgvAVYHRtOLfvZuiPgNBqrQfJBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Z4wPEgnh; arc=fail smtp.client-ip=40.107.236.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/0/kF8y6x1qVI6XwUtecPzQAViaCcoamA/xJFYlOx4EltwPFyUkTr4P1wZ36tFD0aXUwMHWNq3Pi9bBZgDRT5BaUflHgZmz1tebqvsWWuW6bp6bSA1/hBEUSmuW2XKCstPNk3S/BtlHgBuAE9gMWlUt5XJPQOGrNJCZZxcdi953iMRlzAA/7tCjcc0zhCvV2NQvjKE8Yz6DP4RM/ti+QzEEyM5+NopVEU5fVHotb8gwXgC+LG5VJS7m6bupRHxnQrjKXz/SWfk78JmOyd9IYrmWJB/cBphsG2nL0GEYpD72LYE6zPA7KSpSnJvoQ4cFLg7mbbM9ttUIsidWBjHxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIL6YRPv4odiI/JwOd/nU+ORmbxPylFf9/Qu1xko8Rk=;
 b=jok16XGJ2Pcb8Yqn/ZWDxY5Cx+o0TtZYmahjuQ4h9+EodNNd5iHT+/ROp2yAFpx7obWneAqXXoO94j144SkZariMms/Alh8PZHaGQHPQj33gXLTTo85bXh6aj4sLYJoIy9p6eQkkNWNmApftt12VBCQiarhNki5RIYWgml/yCV/pMxh5JtRwC8OlXfIrIb6LCGAnNINZti3Tw00w/Gzpbdbrb9Yt9JwGl/L5oGlPgmGn4h/YDXEi8p/sKVnY0QbV5UHa6tOD26/U2TqYEz6m6RzhSAiCoUynanaL3aQxBfChLhIQR3Gx0iYfCMLylbSsmwwJNqNscZ8DYbxs6i0p5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIL6YRPv4odiI/JwOd/nU+ORmbxPylFf9/Qu1xko8Rk=;
 b=Z4wPEgnhtQuU/WrKCYa0xUbKBIZ40l52f0lpPF4PMmAqclSjGtg6SyCOpcuX/38Xo6dgMN9pGjS2zTlPBgKJKJ43Rj0HIDNd0Oqd2yynlVAgd46mf5yBZbMOYoSfzx0CzW3NcyjeNGDqB2l+rvRICUsXHXxRRsql+I8LnB4bcK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 MN0PR01MB7755.prod.exchangelabs.com (2603:10b6:208:37e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Tue, 5 Aug 2025 18:37:02 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 18:37:02 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Tue, 05 Aug 2025 11:35:40 -0700
Subject: [PATCH v4 3/5] efi/cper: Add a new helper function to print
 bitmasks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-mauro_v3-v6-16-rev2-v4-3-ea538759841c@os.amperecomputing.com>
References: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
In-Reply-To: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-edac@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: CH2PR20CA0018.namprd20.prod.outlook.com
 (2603:10b6:610:58::28) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|MN0PR01MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa6a4b4-45a3-41e6-0f2d-08ddd44f11b7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUVranZaWlpiZ0YxTk81Q3lQbU9SUUJEQmhBYWlqUDNiaHkwdlY3dG9wK0Nk?=
 =?utf-8?B?T09PUHZzQUpWdUJ6dlpINHFlSVpaY3hPcjc1UEpvZEdIQWFuRzNGYjRDUVRs?=
 =?utf-8?B?VXhSZ1Y1UXl5NE9GRVpXRVhZRDZ3bm5FRmNvVTkwRnBvWUxodlJxMyszbWxD?=
 =?utf-8?B?SzFRWkNPcHBGU2czd0tGY2FtZ3dIc1pLcEpuVG5FcFdjaU1yeVpOMzBhdTUr?=
 =?utf-8?B?Z0ZDM2kvUnFtSGFFTWxRSEFDOCtkbnl2akJiZU5qVUJjUFk0eERUV01QWkhT?=
 =?utf-8?B?WTg5VmdScWYrVy9Hc0FpTUY1V1RUUFBSeWtnSUIxaEU1d21hMDlCSWprVHpi?=
 =?utf-8?B?bGM2NDdTNnlPdFN5TmU5UkdQS3VBQUI4TlBuV3lrTTVnbVYraitXcjU0Q1pr?=
 =?utf-8?B?VEZoTi92NXMzNGdwcGpndHVKdG8xTGErbVI4YUJLOGFabnplbWVVd2JrdUVx?=
 =?utf-8?B?eHArQktWWDcxZkpmbmlWZWMvRllFcjVtRWtJSUo2TjhXd0NRZEJYeHk3dFN2?=
 =?utf-8?B?T0NBL2xsNExTMFZ4WnFTT0ZLamMvUkpIQ1dsM3NSa0RLMTZycnRYajc5V2hS?=
 =?utf-8?B?LzNCNFNVRFB2UUtMZVNLaXozT2sxMTFHWklSRi9xWFByU3JzUE1EZG9Xa1hm?=
 =?utf-8?B?T21UbHlSRnY0bXljM1NuQnVLWUlIVm91MDBzK2dBRWhLQ0l6d0NtejJiNlhH?=
 =?utf-8?B?UGhHYlpSdFUram9lL01tMGphVDNNdU83VFozRGFtV29wdHRkMFQ5dENLQkNa?=
 =?utf-8?B?bDB2emlTM2JGVlpWYTNRdHpZOTZEek16WUcwOVYyam1KMmtKZzc2b1FEbGlk?=
 =?utf-8?B?SGszVXlxU0o4REMwMWNsTnkyd2xUUTJTcVR5RVhUZzM0K1ZrRzV0b0UyMDhK?=
 =?utf-8?B?ZkFwM3drS0Y0S0FnQjl4M011T3d6dll1ZTZ0cTUvTkV6TVVBRHgxV09rUkl3?=
 =?utf-8?B?STRkL1lqNXVWN1A3aFFoWDMrUU0rOXJSamh1KzVob2tobURCZXBXQWVLaERu?=
 =?utf-8?B?NTJMZmdCZ2h6ZFZldDJmOFUzK294RkhBZzBNQlN6T3ZneDNOanBReFZTelB1?=
 =?utf-8?B?b0lzQVcxdWlZOVFSQ1E0S1NUVCtpZk4zM3ppbXVFc0taSHZUa1JNT3NieFkw?=
 =?utf-8?B?YlZ6WUhYNDVSbkp1WjVQV2p5Z2l4M1NlS3BHYnFRRTQzNGsrdXFSelpTZUFv?=
 =?utf-8?B?cWZMR1BZN090eG52dUthNWljVko3R05WNXFyKzd1Z2U3bkhIQXhBRDdwcll0?=
 =?utf-8?B?ZDhhT3pKaHdHdTZYTzZjUkR3REFWVTcvTWFmQk1aNmpMeTdrSTNiNmJrMTl0?=
 =?utf-8?B?ZUJaa0o3MHE1eS9BSzhkYXR0M3FNTzdJYjYzZzlYczQySzUrR2U1aStMcVBr?=
 =?utf-8?B?aGNoS0dFMVBzeDlSSzFEK244ZkYyWjV3Y1hnZnZUeEhvZFdkTFFEbjJma2hV?=
 =?utf-8?B?WFZCdXJtQ3RpbU5HZFhhb0JNT1JLUkJEdkNJYzZIUTZobG96eUV2KzMxbHE3?=
 =?utf-8?B?SmJlKzNSd2JRSmZkcW5mdjZQWS9ELzIrVkY5cE5MYWhya0FDWU13Vko1M3FG?=
 =?utf-8?B?SE9BYmpQTG1tdzh5VHFHNjhHVUI1LzNHYkZ6VGJjQWVjblZialh5ZkplKy9I?=
 =?utf-8?B?RXRTYTIyU1ZwT1lEbElBY0NnZ2VZbTJsV0tQbDZmbmh0MVBHTHV2cFZoV1l6?=
 =?utf-8?B?ZFJkOW8vVHQ1QXFxR3YwL2drY2VObnZRcC8weFN1eXVOTDArWE9tV1pzUmFJ?=
 =?utf-8?B?bVVLZkRHeWZWVU1EblVLbnN1ZnNyN2RDN3RyTXd2eFN4TTBpM0o1SUJRUWdG?=
 =?utf-8?B?KzZXSDA0TGI3TDZjYTN6ZzZNQWgrQ09lMk43eUo0dkJ4VW9kYjJqNjVOR25a?=
 =?utf-8?B?Z20wNzY4WHEzeG5NN3ZONEhQdjMvYW41Z0ZJS1FKS1hDWXFyakh5VGY4TFNB?=
 =?utf-8?B?RVMzR3hBaU4xZ1ZDam9hWXd0TWJqS2hhS2Y0VmZBWkx0UzJub25YYjAvaURX?=
 =?utf-8?B?UmZ5Y2UxQmJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?My9yS244R3ZzNVgrYXZxaDN6c0psUy93TFJhK3lrODZvYUdrZ3RRd3p2WkV6?=
 =?utf-8?B?UXorNExnWXV6VXBlM1k2cmdoZFVoeEZHVy95VTljb1JsK1l1Mk0vY0V4NWhv?=
 =?utf-8?B?Y0ZGcDhyMml6VjJBNTlaczAzOE83dDdmRVR6V3d5eDZVWlAzRjRpa0hkLzBQ?=
 =?utf-8?B?dTIzVmtLcFJ4Q0g5R0oxZ3AyR0EyYW5TRXA5YlRrS0FNTG42MVkxckh0Visz?=
 =?utf-8?B?UXM4bkFZbGducG1PVzN0Y0hCMnh4WTU4RVJSVVp5cW5qOGlDaE93VXpSMnBU?=
 =?utf-8?B?bHRSeUNsRnJub0dDbXQ5YXYzQTJCYVVXZG5pTVk1MjBScCtBOXByK3VlSmt6?=
 =?utf-8?B?Njk4aFBOTnhoU1VhdGwraDQwcjNnQXNEaUw0Z2dyUDhiaGhuaFBibGR0ZFFY?=
 =?utf-8?B?MzJjREpoR0M1anNoUXlWeTlXbDltcnh4bWtJTnRNU0ZFUm8xN1FkM05LUDkw?=
 =?utf-8?B?Y3l1bExmRGNpYmZsUmwyTzNjbFlGK2pLbEc3ZHh5ZEUwVkNRVXZZMWZZR2JI?=
 =?utf-8?B?dzhxYXZLU1R5SUdwOGxLdkp2by9HTm9Qc2dNU0IvbE1keUN4b0hweDVDVmgy?=
 =?utf-8?B?UmQ5VWQ1Z2U3NHpseGpneFdiY2NMRCswTHBrR0ZmNnowNUVYNWZhcEFta0tG?=
 =?utf-8?B?N01Ec0ZubnZUeExDZUNkTERyelNSYmZqWWk4RGYzK1VNZEVSdk9JVUNPalRJ?=
 =?utf-8?B?U0lGT0hqZzNtWVl5L0ZuamZkTzh3VStQMXdadVJQTzlBRlEzMkJiNjJKekU0?=
 =?utf-8?B?KzRDdThQQXc2NnJacVgwOG9XNXRZMmQ1UEt4N2g5Z1ZTWEpGNDRBRVZvajZG?=
 =?utf-8?B?NnRETjFNWk1veEZsQmtid2JTRTcyb0hPbnBjL1Z0eVYzbEdLanQwMElQYnUw?=
 =?utf-8?B?eG5mL091VGtCV1dQM3pzRTUzV0tpMk4wVEpxOTUrVGtvMS9tM25uYW5ua3or?=
 =?utf-8?B?alJRc0ZodkNVbldhRmltL1pyMU5oY2VOV3dTZkZBdXk2M3Z6Sk9hZ20wd29a?=
 =?utf-8?B?NzhRLzErNStaZ0R1UGdXdFY2eWhaTGdWdWM0T3IwNjN3VXJPTDVXRk9BcmF2?=
 =?utf-8?B?TVdUb3A1dTBhSEg1Zll2czhadmFGbkU1OThkYndUeGU4eXVEZFZMOW9Cbm5C?=
 =?utf-8?B?QzlSbmlMUWtrQ2RTbFFCbkpuUjREbzUzYUVNaUtPZlRiQ3JLdmdvblVxblJE?=
 =?utf-8?B?aHJwLzUvUGlCaGNvTklMMHJiVjFpRG45dWFKU3M3SkFrM08rVlZjMnp4bitS?=
 =?utf-8?B?TUFzTVY2OFNHZjlBU3YwbmpLR2xFbkRqd3J5SjQyRDhUcnk4YzFxT0orb2Fv?=
 =?utf-8?B?akoxV3NMMWNqVHRkR2NVZDJSRmpIejBySXpJYzQwUGdoZnRXcDUzeTRwa2U1?=
 =?utf-8?B?cHZGbnZmQ1Z0cXYxakM3TFF5bnpEMFJBQ2xyQUtsUWd3clh5TUZMZTh4VE5p?=
 =?utf-8?B?cExlb21lcmErd3dybnFXSHBieTN5b3lWUzVJY05UZ1R5bVErQ0drSXpwMEtv?=
 =?utf-8?B?Z1FiYnpMZVRsSzFoUlZrQVkvVVVyV2VOMUl3aytoSXNha0FmcHBOb1JIRWFL?=
 =?utf-8?B?ZXl6d2trQzRUUGF3WHl1bGNwVGtuVTh0YjkzNmRVWWNwMzlyTWpUTmtUSndI?=
 =?utf-8?B?MjdMT1NJSExHdjhmMTVQU0JoVlNQSTBHeHc5OTJ1cDhsamJ2Y3VqWFF2RDZr?=
 =?utf-8?B?ZFE3alpmYUZvcTZOL2l4WWVMZU0zaGlBenpjREcybVpjSUlJeFpwTmlOeVRE?=
 =?utf-8?B?a0hGN1lWVk4zeFpHVkNsdGZEYjJBUk1SS0hHbkFodVhIcDBMUkVhUEdhOUJ4?=
 =?utf-8?B?LzZFaFMwd0p4VVNOUjRTSFRFNjRZSXFjSDVld1hpR00vd1MyMWZDWHFpYndi?=
 =?utf-8?B?Z0luMHI5aVgvaFFodjFvK21wdXlRMWxKMHovTHY1ZU1zdENXT1piaDVzMTQ2?=
 =?utf-8?B?RnVnZ0tRVUIrb3JlczYycHA3QmJwN3FYTEtWd2tGSll0cW9iQ0RPd1pvUEln?=
 =?utf-8?B?aDRSRnJIOTB5Yk1CN3dxUXNORk90emZIWFlpT1VLWW01dG1ibUU1ZEFnRVZE?=
 =?utf-8?B?dE1PYlhneVVGamEzazdpZGlpMDd2L3pzdmdZYi95ZzYxSWpCU1RpYVhJMUZL?=
 =?utf-8?B?RUllWlU4ZDFOanNaYTlyMFpnaThGdERNVHRwL3RSbmY3R3VVUzUzbnpqMWZR?=
 =?utf-8?Q?E7BwEVpCGHPZKEGAak7Cq/8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa6a4b4-45a3-41e6-0f2d-08ddd44f11b7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:37:02.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gk+01J6bae9M2MnpzYwzrf7hk0r20eMQBjRmq6r2iBGR4le19fyajWYWrfIEGC8azyEcdSVZHundvHxrEd9smubmbQPEPpNb8hA58Lvb1nrgDKhKoc0T40b0gen7Egoo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7755

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Add a helper function to print a string with names associated
to each bit field.

A typical example is:

	const char * const bits[] = {
		"bit 3 name",
		"bit 4 name",
		"bit 5 name",
	};
	char str[120];
        unsigned int bitmask = BIT(3) | BIT(5);

	#define MASK  GENMASK(5,3)

	cper_bits_to_str(str, sizeof(str), FIELD_GET(MASK, bitmask),
			 bits, ARRAY_SIZE(bits));

The above code fills string "str" with "bit 3 name|bit 5 name".

Reviewed-by; Jonathan Cameron <Jonathan.Cameron@huawei.com>

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 drivers/firmware/efi/cper.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cper.h        |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 928409199a1a4009b11cf3189fe036ad8861169c..79ba688a64f8da7af2dad097b9331c72afc73864 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -12,6 +12,7 @@
  * Specification version 2.4.
  */
 
+#include <linux/bitmap.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/time.h>
@@ -106,6 +107,65 @@ void cper_print_bits(const char *pfx, unsigned int bits,
 		printk("%s\n", buf);
 }
 
+/**
+ * cper_bits_to_str - return a string for set bits
+ * @buf: buffer to store the output string
+ * @buf_size: size of the output string buffer
+ * @bits: bit mask
+ * @strs: string array, indexed by bit position
+ * @strs_size: size of the string array: @strs
+ *
+ * Add to @buf the bitmask in hexadecimal. Then, for each set bit in @bits,
+ * add the corresponding string describing the bit in @strs to @buf.
+ *
+ * A typical example is::
+ *
+ *	const char * const bits[] = {
+ *		"bit 3 name",
+ *		"bit 4 name",
+ *		"bit 5 name",
+ *	};
+ *	char str[120];
+ *	unsigned int bitmask = BIT(3) | BIT(5);
+ *	#define MASK GENMASK(5,3)
+ *
+ *	cper_bits_to_str(str, sizeof(str), FIELD_GET(MASK, bitmask),
+ *			 bits, ARRAY_SIZE(bits));
+ *
+ * The above code fills the string ``str`` with ``bit 3 name|bit 5 name``.
+ *
+ * Return: number of bytes stored or an error code if lower than zero.
+ */
+int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
+		     const char * const strs[], unsigned int strs_size)
+{
+	int len = buf_size;
+	char *str = buf;
+	int i, size;
+
+	*buf = '\0';
+
+	for_each_set_bit(i, &bits, strs_size) {
+		if (!(bits & BIT_ULL(i)))
+			continue;
+
+		if (*buf && len > 0) {
+			*str = '|';
+			len--;
+			str++;
+		}
+
+		size = strscpy(str, strs[i], len);
+		if (size < 0)
+			return size;
+
+		len -= size;
+		str += size;
+	}
+	return len - buf_size;
+}
+EXPORT_SYMBOL_GPL(cper_bits_to_str);
+
 static const char * const proc_type_strs[] = {
 	"IA32/X64",
 	"IA64",
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 0ed60a91eca9d6425c9a41947a927b59f7aa2c71..58f40477c824e61c7f798978947bf1f441ce45ad 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -588,6 +588,8 @@ const char *cper_mem_err_type_str(unsigned int);
 const char *cper_mem_err_status_str(u64 status);
 void cper_print_bits(const char *prefix, unsigned int bits,
 		     const char * const strs[], unsigned int strs_size);
+int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
+		     const char * const strs[], unsigned int strs_size);
 void cper_mem_err_pack(const struct cper_sec_mem_err *,
 		       struct cper_mem_err_compact *);
 const char *cper_mem_err_unpack(struct trace_seq *,

-- 
2.50.0


