Return-Path: <linux-efi+bounces-4547-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AD1B2552C
	for <lists+linux-efi@lfdr.de>; Wed, 13 Aug 2025 23:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F295A78A3
	for <lists+linux-efi@lfdr.de>; Wed, 13 Aug 2025 21:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66DA303CAA;
	Wed, 13 Aug 2025 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="rsOH+WxF"
X-Original-To: linux-efi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022130.outbound.protection.outlook.com [52.101.43.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DD52E7BD4;
	Wed, 13 Aug 2025 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119987; cv=fail; b=YU4z6TdDhnKiGFvyfTUbAJzIOWCkOx2SKjRSwmTos77+4J18Fsu3qCNDfI784oIx4xOw0Yut/d8XF/jHke31DRMEu2HF2V9iW1fwQ9rPZ7iiGJ1x1U1GIm60Ql7scAHwF1o3IoD7sxVhSvxNHzTlNkIDYoW93z7PDOveHzzWa+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119987; c=relaxed/simple;
	bh=zDOv53acVGC64ynUcU2gVBFwqcGl5ahdUoqwfCET71s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=i9S7pS4YY56kkIq8P+q6em3VqcsXZfTvk45L5JhxpeErQMT/uPpB3qvcKSYksh/3V0KVuBJskAaNt9G8h/+nelcggegpt1MBFkJxxHorqR0rzkIW/Qktb8Bj9V8s5IV+pd4NHJ9etIY9MbFSxh7TCT4oHHfQp3RafdpEZ+WBAHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=rsOH+WxF; arc=fail smtp.client-ip=52.101.43.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYncCspJpDCS/LdPV0+a8lCHzWnTsMA2yGLUVe3IAvcnadWjWK/h1Mbwd62IHUiL8cI/GaoRnPbpCQ3dORVTuMSsjCmHtmsEcQL7o4EhbsmM+/15FLGOySva8WK8QJwEHcUOyKTaFYB59iv+ZDLac/5+9vVW8/aD0Pc/lwqrqjrrp0CrgbwaVskB2ewVAzd/q1qIUAh156X7tw2hO1TCO7Sz8XPlsAv4oNdVuVXXyqfA2xWXkOfkF0CvnsRVK2OBGXTOOa0mLBoawdiNAMPVNldwEqGBcWJLT/+S1BALCjo+jIwGuA1h+e7/NlPx2MDNZ8L5g6zWQg8OYPgbo5xJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIL6YRPv4odiI/JwOd/nU+ORmbxPylFf9/Qu1xko8Rk=;
 b=O+Rcv0PiUE81jQs0ZmARkyTk+nLm/QKiSUZ+F7q5zsOWGXAHG7kg7dJYwfleCTN/GHOHM5UvwH8ZCUdrHn0p7fyc0XWa79VBfJThNrMM9VpBU4mS5aus974md4OrkKbCxiNcbNQyklUBFJd7VNQv+eKafRPTqtxzOe8rQNXqeoxF1VPVVGUVERfU/BR8XoMTE6PR0yciGASjpUeX8oqqdwaMDR8i7dD+KJDkA6vlH5kXno7qBZatWuHy8g8W/xu1GCQWfW4b+l61ohhkfbxZrG26x6KVFhklkrLkk2dBoTyruv0tb5R9aZrxUfCHrCMqPkpwJoMKiOhCNwLwmZFH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIL6YRPv4odiI/JwOd/nU+ORmbxPylFf9/Qu1xko8Rk=;
 b=rsOH+WxFE+vli1W0sLmtFKt8Fpv43MagL7ktateUXfX816ubHnYSt6u6q3Px9LzXkMoGCH+6babmTjQsb/vGFjIldapo0yf8Kxp+UzuAE3Tnwse6CLlh7kvRV2GxY6aN1DsQb1d88uo5uLPfuS9mRg4yY2jtUD5XZAp9VMFBQgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 SN4PR01MB7423.prod.exchangelabs.com (2603:10b6:806:1ea::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.14; Wed, 13 Aug 2025 21:19:43 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 21:19:43 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Wed, 13 Aug 2025 14:19:16 -0700
Subject: [PATCH v5 3/5] efi/cper: Add a new helper function to print
 bitmasks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-mauro_v3-v6-16-rev2-v5-3-954db8ccfbe6@os.amperecomputing.com>
References: <20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com>
In-Reply-To: <20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-edac@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: CY5PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:930:1c::35) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|SN4PR01MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: d2325ed9-59f0-47a5-ee2b-08dddaaf1f17
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QitWRkRPczh5dEZsZ0FFTWVNM3g2SURudjhyS0ZjbGtKNVp1aG81MHhEeERH?=
 =?utf-8?B?bjkzZnNHU2xaczBaeW5aTklSOXlaaTlqZUhZQ1lOUEdVQ2Vkek85YmhaT2pI?=
 =?utf-8?B?bnZ6dXZ3SmxOb1pienV0dlJrTVp4NGlpQWVPN2p5QjE4eDFlU0NXdEVPVURp?=
 =?utf-8?B?NWFia1hwVGs3YmsyWi9tWVI3MjZOWGNhUkRzcDlIOUI5Tk5rRHoyTngvOHJ6?=
 =?utf-8?B?cUR4Q2dmNXVKWm5wbVdmZW1HMEp6WDU5R1VJYjNXMUJEWHFCMGZUbk15alN6?=
 =?utf-8?B?djJnMHBsZHphWHZFdU1IM3hGcUU2MFhUSnltZnA3WWtqUHVGR0lwa2gxdkVY?=
 =?utf-8?B?dEJCeTE1a1FwRC8xaTF2K0JsRkcxL05mbFdqZlprUnBva1ZuM1B6YVpQUElT?=
 =?utf-8?B?cWV0MmxvdFM3SGZHaEtHTjVnYjVWcXU1WUhraHRERElXVUdoUVdvd05YeUtP?=
 =?utf-8?B?WUtYZ0x0SjNxUFpzclF1V2l0RWdENmJuWEJmeHdVRUI4blIvZEpETHNzTUVr?=
 =?utf-8?B?OWdLVHdqRVpLZm8vRUs1S1pxYWFqakdBajJjNHozanFJOWdwTmFEQldrT3px?=
 =?utf-8?B?L01JaGpnSmVZWUpZUDNrRnlOWTlQZG9pa2xWUnVtYlkzRkI0ZUdRRHRvSDhV?=
 =?utf-8?B?cHdkYVlLMFY3Y1ZxSE45bzR6QWhBdXVSdFllQ1JKUlRhVVFZc2hic2oxaUto?=
 =?utf-8?B?bG9OeGlndzNkc0VUbXRaN0w2QlRhQUhzTDAxMUNXSDZvWEdjQ01EbzYrMEtK?=
 =?utf-8?B?bzM4RTFmZkZZZFFObFArY2ZMb2tYcjhJMGJkN2dROUpDY3hNYnM2WnZCSG5R?=
 =?utf-8?B?YmFTdjNpN2hXTHNZT1NmVkFDWDBnbEhxTEYrbWFMd3BZYkJXOUx4UXNZT3I3?=
 =?utf-8?B?dlZRZE1jd0ovWG55YUxCSXVOV3NTczlKVHpGWDhzRWM0dU5YY0pobzFXUGh1?=
 =?utf-8?B?Zi9GcXl1R1dHQmxZVEZHV0NYcFp1NHA4b1ozMFhBYmVuMHY1NG1LVXdYaGRS?=
 =?utf-8?B?Sm9MN0NNeWtJOHZ3TzBybG1vbHFvcWZpaFJ6WkJrOE5BR2Z4dENmRkRTdEQx?=
 =?utf-8?B?WW16dnhwYzFwdE9vUFdqL0VXU3JOSGpRZmJ4c1dWRkRBTXVUQVI0eEptZXVy?=
 =?utf-8?B?RmtXL3ZXM2t1aTdWMUJIRndkOUFPRi8wY3hSQWRGd29tRndsdCtQTW9IWm44?=
 =?utf-8?B?QmZEUy9nY1pNRjhqLytGdTI1SStoRm5ock80V0hsY04raEhXM3MxdHJvUFc3?=
 =?utf-8?B?UEwyNUdoL29VMFJaL1hSbGJwaXJ2NkZxNW10aDB5QXlkNmtON3NHY1dsWDJJ?=
 =?utf-8?B?QVFEc0VxQmYyTjJvOXdmS2tKRlNYMGhNWlR0N0JiYmVtdUgvU2FHUmt6cDY5?=
 =?utf-8?B?dWNBZzJ2OHJxY3I4U25hdnQvcHF5dUlCaFQyaCtGdy9wNC9JeDZkbmorTWRG?=
 =?utf-8?B?a294Rk01VHhMZGtyNHliV3lxanlyb0l3UUVUTHAwQ0hleU4zUE9xeGJVdjR6?=
 =?utf-8?B?aUFFOTZ2OFU0TTRxeUlTMDU5c3ZMSTl3aG9JZGtpWXhCbkpxK2t4NjhLMWI4?=
 =?utf-8?B?bFdjL2NWeHQyelJnRHpxWTg2T1VTeHFzM2R2aVhCN0RmaE9vUVNPb2huZlJN?=
 =?utf-8?B?QU1kaGMyUlQxT0Nob2pnVXZ1bDVDZVVYQW91UWVjbm9kT1g0NlJ6RytvaUpH?=
 =?utf-8?B?TzRTdkh0YXRhV1dmMVlMOU9VWnJaTWpBL3pRWllSQzhCeWFMNHVHV3ZINllI?=
 =?utf-8?B?cEFWcUNOS3hUQW1kTXp4YmhieGp3YlBpdEk1djE1RHpBTThKRzh3cUZaaXhC?=
 =?utf-8?B?T0daSXhoMVE4V2hWVkh4dlduTUxVNVB0dUgyYnFkT3dvZjFtSXdnTzRKRjNU?=
 =?utf-8?B?cDgxZjM5Rm1xRktIT29kU2pZMEZHclRhcmgydkRnNnVaVTVTQW4yY0NFblR6?=
 =?utf-8?B?K1Rrbm5iaCsxVk1RWlVpcVliQUN1U2ZOdUQvMURZdGE4dGpneCtRVWV1c0Fu?=
 =?utf-8?B?ZmFCZHQvN1RnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXE2SGtEK1QydWtBMnlPbVRURXdadHVlMGtPUkZpTDVNbTdxcWVBclM3ZG5w?=
 =?utf-8?B?YnlibE81ZDYvTWtGaVVsVTBaWDlMRXRKbWwxNjhzTVpGakxSbjJJY2o1RGUy?=
 =?utf-8?B?U09SWHZJRFFMN01CSDlscWV1TUliWjR3TEhQK0VrUTZCVkJOYUZ5NlZuLzZY?=
 =?utf-8?B?SGlrUDdmTUl1UFg1M01kc1VqOHA3Rmx5U1JmREJKSjR5UDRLU1AyZ2Z2Y2FD?=
 =?utf-8?B?WWlUVmpXbFI5TkZRL0o3UTlQVzFZS1JZOHVIMXN1M2RJeVVvTkhHUElkZVpw?=
 =?utf-8?B?aXRvU1pYV3RLKy9oUlVlYTFlNUpuUHhXa0lYOWg2Q3oyZS85K25Ua3pHVmh6?=
 =?utf-8?B?VnJKRVBKeFBvY2h1WnNtc1p5VDQ0QWJNVjBBNnduVFBFVEIzMEsyY2dCSjVI?=
 =?utf-8?B?d3NMcldHT3BjU2NYcFk1d0ZqWlBJRFl0WElsc25yNjNaV0dBbnYrVzBYNWRz?=
 =?utf-8?B?MTRtRFp6UnNtU3BjbkJlczdVYTBlVzk4cklLNTNuOXJ4VXpkU0lLdGRPdm5s?=
 =?utf-8?B?ZjRHcTg2bCs0bEFsbXhrM1hyNkZyQVF3MC9WMGtRN2I4NFhSeU5jZnZ0RzZw?=
 =?utf-8?B?aVc0a2RvaitXU0ZmQnBSRHlCK1NjV2N0RnhiSFY0dS9KaTNTSFRKK1hESFFC?=
 =?utf-8?B?R0FoR3YxQVlUbE9uVS9TaldZd252QmZLdGgyMDkrWnprYTJpKzdqQzgrOVY4?=
 =?utf-8?B?eXd1TVE3VENxRjVjRURhUzhoRGlRMmgrWTFxREs4Z25GMFhMdHpOSGxRN2x2?=
 =?utf-8?B?R1JFMVlkbldyZ3JXb1hCU3BpUWF1eEFYdndZSTlvWkNFS2lvUU1PUGl0UFp0?=
 =?utf-8?B?cmprcFhLVU9OZUxXd3Vscmx6SFFpU2tGdkxkTGtkdGZkSzdKRkxvVGxSclY1?=
 =?utf-8?B?OXZyVURKVFVFNG5uQXIreVJEMUNXWUtTMm9uZW5jdFFIYzRzVS9FR1RWOFlU?=
 =?utf-8?B?cFlTRHVyelgraFlvaktkSy9KS294YVpTM3gwWFpIYUtLVzkrb1cza1lGY3JB?=
 =?utf-8?B?aFdsaGlrSkVQVWdLcW1sbFkrU2Q2M1kwZFJEUUcvWVoyVXAyK1NVTUZtdHRF?=
 =?utf-8?B?L21Xa2Z2SmF4VU9HS2Q3VmFER1pOa3JDTzhGTm1iQTUzcmJWWmxUdW0xRnJh?=
 =?utf-8?B?L25HVmdkM3ZwUDU3b2dDYSt2WmJEVWgvL1VGTTUxUFg2TTFrTlRJSHcvSjY5?=
 =?utf-8?B?YXpXcUw3d0dpRUdIR3dqNkJWUTFoekcySkFNUkt1OSs1OElYSmkvZ2ZPdzM2?=
 =?utf-8?B?WXh5UkU4QWwxWmtrR0pBYWJhQVAwakJTZ01UdW5tSW9WR1JVNmllWCsyRzJh?=
 =?utf-8?B?Ukw3M09zSVlOdzNqeWpkMHQzV0NNUTJnS0d5bWRRWjI2TnpYOGQxQlRkekVo?=
 =?utf-8?B?czNHVGtGY3I0ZmRUbWMzdzJVdDg5N2IzdG1QZCtOR0VLWlhxZVl2V0pCelZT?=
 =?utf-8?B?QTgxeFFoVnR1ZkdPTkxoaWpTNmRydGRvV01jaURwWC9wUEl4ZmZrUm9FOFZz?=
 =?utf-8?B?ZTNyRG02M2ZhSjcrU1BQMEhVV1lMeUxSaWJTRHFlS2lhcUUrSkJ1Z3Z0elNk?=
 =?utf-8?B?VGt4ZC95ell4QkUxL3doNmhRMlI1bmtyMlZjcUNXWFE3TDMyRDlwNXZQN1VQ?=
 =?utf-8?B?QmhzUlJNeVlmSW9ra0pQQjJ5VEZFRDd4djE4SWZOZDFzMzc5cllmbHVtZUNs?=
 =?utf-8?B?elFISENCY0FxTi9sVktDMENCZmhJS1VQZ2tJVTF4ZDBjTk42eWJhWkRIMGNi?=
 =?utf-8?B?bFlvd01lN3lXaGN2TjduMFBLMWdPcTRUZlRMcjVOZG5jdEozNzRwTGdJeUFN?=
 =?utf-8?B?SkRmOU5qb0pLY04xOGZtZkM5NjBSOUpMNUJ2a2FERE93Q0ZGVzFWLytxc2dp?=
 =?utf-8?B?N3V5dGtaWk4zVUs0MUt1WkovakxSUytvWDFUcGV1Z1pMMStnSmlZMTJOU2py?=
 =?utf-8?B?TUpMaWhaZGdzdzhqS2k5YXRxSG5MRFdwazlyNHo2UWdaR3dCVTN4QWxpTXBW?=
 =?utf-8?B?d0ZRSEFTQXV2RjRNdCsvL2sxM1k3S2FFdEo2Uy82Rm9IYTZLQUd3TFVocGNh?=
 =?utf-8?B?VlVEazBNTW9IbjlVMDNsaExaUVVxbDd0d1QwMGJnYlBOL2JxUDBLUk9Bc2Nz?=
 =?utf-8?B?S0xwZWJzSnNUelkyeTVaUStMSElYY0NaTHVpOUhVcWh2OEI0eWNTUldncjlN?=
 =?utf-8?Q?bCY0RwdDRh7ji9dn0vet/EI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2325ed9-59f0-47a5-ee2b-08dddaaf1f17
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 21:19:43.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnNvTeqi0xk7kuLzXPim13tmKSndrIlHdK/HyMXHv8dbmiTx0cj0iyj/3EpWP2SHjvtONfqAu0bCJu20ihu0ox96Vz6eQMUUBqnPyiqbWmz1KmdCiKAMjmkBeLbbhhqG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7423

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


