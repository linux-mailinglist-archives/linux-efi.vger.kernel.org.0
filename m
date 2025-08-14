Return-Path: <linux-efi+bounces-4556-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7647AB26D1C
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 18:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E688E602EEF
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E916B2FE04A;
	Thu, 14 Aug 2025 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="tfKzbTf/"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2136.outbound.protection.outlook.com [40.107.94.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA31FE444;
	Thu, 14 Aug 2025 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190395; cv=fail; b=TBHChZTXlNLtagu8mqUR7RxjnvnLMeBcRdSlCyV3yfrJe20qGWQS11biQZMl0bTbxJ2WV6pLtmJAOCneBJlQU8JehoIV5rZfI8Xe1foInQ6bs7ooQkuId7nu7ro1i6VGomR/XFplWz4WXzYucej7UBUK82BnxXcCTbWOvQGg2b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190395; c=relaxed/simple;
	bh=WIm4YZuVm8GRqQ56fl77W9tQ9ZnRZw0TB9sxkSlwrhE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IHwtjn7ynnLDqPMT43+H4Mq+8rlCG2e/gITPkWv7lZyiGLCmyF/eSeY7gttkCAv17p+GKAL99RKWAHn1yE5t3XKz5lj7pX9F+2LqJCviw4QOLfW8D0x0UD5w2/Vm+5qgDvqSQP/vZh0xOmXeowB0FxoLsGpq+//XzIbksXhzrBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=tfKzbTf/; arc=fail smtp.client-ip=40.107.94.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXshcARbhq7uDD24jLTF0nNHwC2T0e9ZX0OADIrfvVKIWtqsdaVyuhxzD+WOJHCjLrsv1shWIDLclQeJXZ20C4V2ha63tfVF3TNOAPI355Z037ETK65A8UqAHvxKwr/kY7OyJCZceSxEYCpEtU14xhfTNZySQS+S+2jZQgrEnp5/WFRK4jOPLoBupdf6fAhbjzRWoTBCOUyftSRywwRwpWh7in9wmo6p00RA5/g3AA9UVk9ECKV6WMhKlR5F4cBsi7ymCMuoJOiXWEdPKNV8A9UGOQAIKecB7WdB/E2fDWJ0FJCCXUwTCosi3s2EDvvIHT5AyFlpIOPB07O8luzOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU7qPRDo098enreObDWvO8WMDj7vA18Bpd0e6VEm0wQ=;
 b=NWdsRjdOhx6ZmVa/xAKIzaSZ9P5whlYqSi75ef1v3FfCSbXK8Yy7GiCIGBjbnnz/2BpRehADhof1a/yDzz+v1nquHp8gMVDHSs3nIgB3WMUJBxWVQu3Zy3qVDhXQLvKYdMHe7eHRmRt+2e5bgF3MsgFIsPzUGOLC+ybiiKOWv94ZjkiyhteHa/rnmpnVoh7zkhwW9Ul98udUhhz8M4ZBNBF8sIllsVXBzZKKOOp85wbWhaEZjg0NAgiMuHWC1OChjyb4kFIWQiOXs+y2ROx6y/JBn6yVQUBOiP1+88Rx8H3kWPN9yt437vlM4e4iWWSXzeDUhbt2KfqMwyIQzaEJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU7qPRDo098enreObDWvO8WMDj7vA18Bpd0e6VEm0wQ=;
 b=tfKzbTf//nLOk9lvSm4x+vwmwlnb84i+9MfN3K0hF6m5BcRX1rahgwzY2FdH7OnOrNbjVs26you+KpSN64du0+E0jUUEH8LPY2TljcTBzMh84Hj2KlDJuzetCtE0XcRxOYw1+x7ySpjBNPbj5afjrubY6pLKlEVt0D4xvRFNAA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 BL3PR01MB6881.prod.exchangelabs.com (2603:10b6:208:354::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.18; Thu, 14 Aug 2025 16:53:09 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 16:53:09 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Thu, 14 Aug 2025 09:52:54 -0700
Subject: [PATCH v6 3/5] efi/cper: Add a new helper function to print
 bitmasks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-mauro_v3-v6-16-rev2-v6-3-e5538d534aa0@os.amperecomputing.com>
References: <20250814-mauro_v3-v6-16-rev2-v6-0-e5538d534aa0@os.amperecomputing.com>
In-Reply-To: <20250814-mauro_v3-v6-16-rev2-v6-0-e5538d534aa0@os.amperecomputing.com>
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
X-ClientProxiedBy: CH2PR19CA0007.namprd19.prod.outlook.com
 (2603:10b6:610:4d::17) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|BL3PR01MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e414a8e-3aed-41d9-bbba-08dddb530c89
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2RCOWpFbFZwWGVTY3E5a2ZXOURieks2MVZQMWVETGdkMDJQSjNxK0ovTXQ4?=
 =?utf-8?B?NlN0eEI2cmdGNEJEclROMlRmd2VhWCtHTnZMMi9OTjdQWjVDYmhhWXJwY3Vr?=
 =?utf-8?B?R3YveHJuVW9DcjRhY3d6TlEvNkJVbTIxWGdaYzhyNFpaaHFBZWdhWkUrWUJ5?=
 =?utf-8?B?T1drby80ZHppTVFzdXRwS1F6RHh4WWpJbmt4eDJTazhqVEp6a0p2azBiNDF5?=
 =?utf-8?B?MFBjUEpDSHpOa1FrOE5tN3BTd1JIek5xeERmWCs0dnJCR0tFY2VFRU50ZkIx?=
 =?utf-8?B?Q3RoeUdqZWpQcDcwYndIYVRZM2hFU28xVXgzakNGL01mei92QmtaZkJyNVBX?=
 =?utf-8?B?UnM2bGtjaGt0bmJ1OWo4N3NyaktwTWNaSGlBT25kZ3hCQnZjZm56WHZUU0lr?=
 =?utf-8?B?YXd4VGxNQk5vZnpYSm15U2VwWnRxOTlYYW1lT1dla3lhQmpjbDNaTkovM29U?=
 =?utf-8?B?OUcxNHdIMWF3bXFpQ2czL0JnN1RTZnBiUkU1YW1rK3c1eFJtaE1BdmFyNncv?=
 =?utf-8?B?Y3kzU1hXeEEvVUF3emFRSFlsWng5cERObFp2RlhLTXd5Q3dFc2tiTUFiNGRK?=
 =?utf-8?B?VHgrWitvSWF0cHIvbFpZM2pVOUZGdUxMeWRzenBhb1NNb1FjS0ZLYUs3OXQ2?=
 =?utf-8?B?YmVDWnJ2NXZFR04xL3pGMDV3U1JBNnFYYi9hM1VBTlc1NHZISzlmUkdXaTV3?=
 =?utf-8?B?dHh6VEY5T3BJK1Z6aTZRYjFBSHRka1dpOWJ6dDB6ZTA0c0grYnNKdFNzOXVL?=
 =?utf-8?B?WjlJbWxTaityVkVjR3YzQUZLMld0SjhmNHM1Z0RYNEY0dU80cHZJMTB3Vk9p?=
 =?utf-8?B?dnNvUm1rcnRIOHdKeFlob2RSNE4zU0VRS0Q3YnltbTU0WTgxc0tSTVZnWU5C?=
 =?utf-8?B?Y21QOWgwTW9aalBGWGthUWVWWHBRbW9CaDNZbG8vSXJLQXRWeUN0N3Rid2ww?=
 =?utf-8?B?c1BRYWRXUHFuYmxISGtZM1E2WWZNRkRVTnNvbVFNNWdYN1FEK2U1LzVwczBu?=
 =?utf-8?B?Q05KdWwrcUhlTnhBdWFHQjMycnNwSmFxVXlnUjZWcm5HbzR5alc0Q3Y0Mi9h?=
 =?utf-8?B?M1NmRGVlL2RXcHhnL0laN3BUYm9uMXdGRHBqbHVCRlpleUpXQ3VVZk55MGZx?=
 =?utf-8?B?UWpGNzVISUFTUWM2eDFRbHQxV0dlSy9ucE02b080L1dGUllZT0lDYitkeWlI?=
 =?utf-8?B?b0hMbjl5QUl2amxQaWR3dFRtL051WXgvMVExYlRqL2ZYUEZzbUxCUmVibXJ3?=
 =?utf-8?B?Q1lmY3RGaWEzcGNYQ2RGN2MrTTBJK05uU3BGUFNXSCtSb2w0cXFYazhPTmtr?=
 =?utf-8?B?ZTAvUWxyMFZZTUllTmkwMTgrZWhYVnFFVTdGMDEyaThqU3UxUXBjTTFXeEY1?=
 =?utf-8?B?d05LeVF1eHJmUkhhOWQxK3gvTkxYdWRZT1FUdFBoR1d3bnBXcE5WTGxnK3hX?=
 =?utf-8?B?U29XcGtjSTBINUVUck9qeGZMbWtWWUdwb0ZsdjRaUnNaa0tlcmFjYmVqT0pC?=
 =?utf-8?B?ZDZGMjRBQ1lXUDAxSDBSQW1jQ0lLQkZzSnU2NWxZaE51dU1RNTAvWUFpc1JZ?=
 =?utf-8?B?S3k2MzlDQzMweUI0Z2NtOHJlOWh6a2pVNnFEOFNwRkpCNiswZGtHMGJ4eEdM?=
 =?utf-8?B?eUNCdGJrb2FEWGx5VFdzNlExcE5mSm4vMDV5WGYwQjJQWSsyMzhXaG5OazJ6?=
 =?utf-8?B?d3N4TG1Da2NXRm1nNzVST2tVMzdreUMzcnVhNWFRRlFrVGxaWTR0dmx5VjBq?=
 =?utf-8?B?TUhLMWRlaWg5eVZVakFLYWx2WFZNMXhsYXMrQXBOSkVGRFV0UWJvdTRtL0Zz?=
 =?utf-8?B?cDAvYXZQT21yeGpobzJobmFZc1ZGSHErd1lMZ3FQRXREM2VWdHJqSGs0K2sz?=
 =?utf-8?B?MDBLSVN0Tk8vaTNjTmRBeFpyN3VCcGdVTFF2Rnp0aStPY2J6eDdaVGo4WXp2?=
 =?utf-8?B?ZkdiUHY0citnbkgxV3N2ak1lV0lCakZJV1NlRFJZQzdEbzJtT05LZlRtcVZo?=
 =?utf-8?B?eU52ZEZpVUl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGtRM2JVTTQzL1pVN01xbDVpUXZtQXg5Q0JLNW95eTFlOTIzY3o5MUJtYXh5?=
 =?utf-8?B?SzdmdkZ6SjdnSENvSjNmOGFBTEZ6QXRxc3ZMeTFVc29YVUxCVGlFdkJwdy8x?=
 =?utf-8?B?aGxaSit1TVpWcDVnR2tTWG8wWWRqaHNIT2tUT1dadzI2eEY0QjBpRmpKZmty?=
 =?utf-8?B?dk5QVDZpSDJlMGQ3YkxybW1uYXltWCtoWTlQaGNEUk0yVGNnZ1M4dCtiaWRx?=
 =?utf-8?B?VU82MUl3Q3JwNUlEaWxoRndWMEtJYnZ5dUlSdjR0V1c4Z052dEoyR2VEN3NC?=
 =?utf-8?B?OUp2VkYydmNiaDcvWEtueXRyV3YwN29lQjZucEsxa3o3cm40Z2wrMVB1b1ZT?=
 =?utf-8?B?M1ZMQ3pHWitFc2pEaUJob1hzenRqdkxTVlZWcVNucGVZRFhycW0ybUpkaEhn?=
 =?utf-8?B?R1V4dDJvOEhld3dvQkZSVFJ1VW1Fd0xINEJvRlJPNG9hSFdmK1duNWIram5E?=
 =?utf-8?B?SVNTM05QYnlkY09tNm4rRmljbDZoaWVVekVaY0VUYzN4NUpLTngvcVl3V0du?=
 =?utf-8?B?RmJPcE9KSGZ1bVhVRDNPSzRKekh6K0VhL3c4SjIzeVhLUTFDaDJHSWloY2tH?=
 =?utf-8?B?UW5VRWFidTFTQUN2SytGdjVmRzNwMytiSStMSWVmM2M0OVNNMkdQQzBuYm1E?=
 =?utf-8?B?Y2prM2xHbnljVGpXdkNkaDhNK0JLVU9BZHRlZGtmZVhUL3E5Z3p5VUxaeWxz?=
 =?utf-8?B?R1E3YzNrekM0WVRDTEcwZ1FvZnpiTkNjUjU0R0Q1a1kvU2VBTFNHcWpEcytY?=
 =?utf-8?B?V09iN1pER1p1cmJlK25kZkcwOFFnb1dVWGFlSUFySERHSFBTRjhETkRqRC82?=
 =?utf-8?B?SERYWXdCZ0xZeGVvbmdZc29ETU93RmVyVFNSVGRRaWdtUnREcEJuQWJRZkhq?=
 =?utf-8?B?eWRxZTVCanBSUlIzR1k0K0dscFdtTUlyV2ljMlhBczhDZXczWUo2YnU0MmQx?=
 =?utf-8?B?MnYwdDBjSitQK2ZITWNEdFZ4M3BpTUJaSUI4UDlKREZoQW1wTkFzOVJTbDhQ?=
 =?utf-8?B?T2FyMU9wTUMzTFFFYXMwUzRtcTdXeHY0aUtwUTR5dWZMeTFMbHZvQlZvVXA4?=
 =?utf-8?B?akJOdlc2eEQvSWNSbUJxTW5BL3FxckRqd0FXdFRHeTEvUk1ZRUdsckhNaVdN?=
 =?utf-8?B?WVJuK3VIVlpiMzdtcjBqLzBnT3lEa0lBcSt0M2o3TWFnQ0k0ZUM5RG1EdkE5?=
 =?utf-8?B?eGpRSHVhdGFqb0MwYkk2alZGdkpZanBXQktiK2NwSUNNOHhJdkVSYWQxMm5j?=
 =?utf-8?B?SG4rSnFLMDBtcU1XeTZUemZweVZISW1wZkJoV3ZpNTFiaCthZGt5dzd5S1BS?=
 =?utf-8?B?ak4xeU9LVnJ0V0ZuUnZWNVY3cGQ5dEY3a0tFcjkyVEN5ZFJnN3JvbG9YdWlS?=
 =?utf-8?B?a09kYUp0Rk9RM2dteGd0OFZlNzlFZ1g1U1V2UjFiZjc4MGxBcWVTZ1M4YkZj?=
 =?utf-8?B?QVdwWTBBYjg3M0ZGYWZtZTdDZGNyOFNBdVlYTE1xVUhIRFZzaVkveno2elFL?=
 =?utf-8?B?cW5oQnIzSEdLTGR2YjlTc0xEMVV0aDBKY0VvakN4UHh4OFlNSTNvcHNZN1Vy?=
 =?utf-8?B?S1YwNGZlTkdKMjNGakpkRHg0T0FPMHdwcjBsRmhrRkJvUzhYaUE0ZVpudktQ?=
 =?utf-8?B?TUt3T3V5SmJwNVlpbFh1Zk1ZS3EzNmx6aW9rb2l3b0VLVURudlFZTng0WnZp?=
 =?utf-8?B?M3FIclBjYkRGUVd3dERwT3ZtTUU4eVVVV2NpZlZIY0E4MEIvSFk3R0VpNkZE?=
 =?utf-8?B?TWVrVVgrV1k1UjdOUDBlU2xGSHcwczdzQ3RMZGlXY2h6Ti92NzZXSFptY1Mz?=
 =?utf-8?B?K1ZBQnlQTXdQRElmL0VBZ1ROY09BSTZBWlJjc3ljaFRmRUlwY3ovck44SHlu?=
 =?utf-8?B?bGVWWWJiRll1akJNNTNOWHh6U3Qra1N3V3VmL2hxZTVJUFhmT1dleXBOYkxN?=
 =?utf-8?B?YVJ6Z2V2TURVQWxPdjZSYkszOHM1K1BpSy9TRzNzKzRUOGlvZWZZZjE3QmJk?=
 =?utf-8?B?SlYyTmM2dFZMeTdwS3kxVk9FUUgxRktLNk05WXM2anNPcnNZUWE4Q1I2R2VE?=
 =?utf-8?B?Tloyb0RqQnJNbnBnUjdCQ0ZnRjI1RXJwbUdjMVMvSWhsYlM2eHN1c3FyNCsr?=
 =?utf-8?B?OC9vSzlTcnNvTm0wdTgvSlg2YWdXaTQwZGhqc2paS1JYMSs0OEErMVlURWty?=
 =?utf-8?Q?DyBnD1Hu5rXg7hkFF38rINA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e414a8e-3aed-41d9-bbba-08dddb530c89
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 16:53:09.7302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqYlvWHvgGI7ZKa+FPY4Sx5ldiTfLGSgf0jSLzFdqpwGnHc9EbQcrW7sOCY08I+fpTARTT567DfmfrITGLuh/qYEaxTrkN+CSeM/Je9THt5otrHFZjb/k+noOsiJx2Z4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6881

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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


