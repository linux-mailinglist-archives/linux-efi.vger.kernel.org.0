Return-Path: <linux-efi+bounces-1985-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6455A9A27AE
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 17:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9048EB26B18
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 15:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148C41DF26A;
	Thu, 17 Oct 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VP2ggwGp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KDVkJ/cx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E801DED6A;
	Thu, 17 Oct 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180609; cv=fail; b=e0bUXHh/1zc0v+7PptYueL4E/pZuuqGhTTxWYM5r9jSUcw/beK5nro/UvNjIp0Pu33OUkw4Sj977HCxbsXePL3lpbEAv4Idv4Tdpwb2MCNtrb1owUXYzFCPeU7b7qMeRedCCDcXHRjfm8xrVNNFUzUk2reOYKFhMGAgSsEL3vcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180609; c=relaxed/simple;
	bh=QUM/RXskzNEvZWm2LUlMC1t8mbCmrAXaBOK1168TkvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QC+32G9t5va7JAVLx77GAYcQHkh4bKKCWotjGuoqnaPpxI0x9VlUMNif/fPw3zutfkpiWOk+TFVn4lQmiFjAImwZcD++/7kY3Ob7UF3Z6AEU7BZNEMX/itES6zmxLs/7fFc0q0CTqj5WLkl24CMMKXQjmAQkbmkO4GH2XTSMsnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VP2ggwGp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KDVkJ/cx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBnEV019227;
	Thu, 17 Oct 2024 15:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4MF5i3cQYFYfuhKXtzxnuneBu8XAWHMFHEg/5rxPIZ0=; b=
	VP2ggwGp6GlYUqrEeXudyk0zlfze/SOQpndREL89ixpNFFlN3WgGBBTrQFC7xxpf
	T/JpyOUlGYAhKN+brAqtqXQPXkBzf0aRWvM5N8RYZJLOzo6geA+Pj0RNwFwLToa9
	yowI+owbZ1/mSqG7pSX8310NWTDkw74FkTfyT/OK9Xrqaw3hCGY/4vpouktvoIT3
	sTVQj6KkpJP05TfzadWmArVojpbphH0FhMRqXOcTi2mLpQ0Y3QmF4L2Ewp+0RaHj
	O/DMYXU8+21u8oMsZEQ4E0cPhs7wfvLFv9eK0cC5QOfa6Nvw9OQs8KQWH/yLIbR5
	GAqi3oeIYyUh7EbMvFg1tw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cq6qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFPSY8026291;
	Thu, 17 Oct 2024 15:56:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjaej31-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RS8lq6sKI6M3daDevwiYYLxtUZwjvdahXDB19WdisBWoZAiQ93fWPei4i5aI7stQ6rtwFVrgoP1HwlzPYKtn/EiLWDPbbVFDTQvcbXud766j1gg58vkaXz/13mlg1jmsTFrDgTNx9Zz75pAsLvAChb6ufl5wIzI310MRg+AXyeZDUgrwQFvY+A1qZORCwcA1b5yZK8wjTiSrbiFm5tUwpgITa6wmlpwoYmlwB0VV0UCxaLetrn4Yaaa7yCMjfA41Sl8LODatBiWi3o8E8tya1HJlYMqyxcZhEb/lbQHJmC5I+E76xu7h4KnJngSle9dnS4DZSzbeBrX9blnXg3Hp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MF5i3cQYFYfuhKXtzxnuneBu8XAWHMFHEg/5rxPIZ0=;
 b=WCa6q057dTLjAizCMGuJt165uLiEYItqo3mrWhqgrttm2HBMRPo5AJ7pgwVJIzXzhUv0EImVw0LBF6+URNKZ8NMWqE3AcZSEq722s67JIZG7OzCI/BsVgv7yuYnIgMgKTTqhUPFFysvuoMnTJIZybqK3fj+KDlhuwNMVZ32pKleSndnJXHUzo5vXMJU7o9PVfB6MKMlvnVOOue5EyTOWWFSK5KWebG9xlrax9sEUKNKGyFWXOLnsR/Pa6lzpB/vchZSui1Ut05u3+x7NUkBMFbIFY8mWxfm8u0sSdYLQVQy7heHNQFWjJmbfIpZ8k6ky5ihUGnW/dA1kNJpBUtiBlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MF5i3cQYFYfuhKXtzxnuneBu8XAWHMFHEg/5rxPIZ0=;
 b=KDVkJ/cxonTuRszknAr46oNbcU4W4QhuEuonAjrD5dxktqY/1fXsRkqKKM6TbSMpiw6pD1G2TQFOeT5l5AJ3M0WoT5U1JPsy/0SDqSczRgKsdlPvMXty2hS6UiFwIFn0eBrHvMrXk57s07bo0QT+ruSpscLvu1qNOJ22hTfd9Tw=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by LV8PR10MB7967.namprd10.prod.outlook.com (2603:10b6:408:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Thu, 17 Oct
 2024 15:56:03 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 15:56:03 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, mic@digikod.net, casey@schaufler-ca.com,
        stefanb@linux.ibm.com, eric.snowberg@oracle.com, ebiggers@kernel.org,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [RFC PATCH v3 04/13] keys: Add new verification type (VERIFYING_CLAVIS_SIGNATURE)
Date: Thu, 17 Oct 2024 09:55:07 -0600
Message-ID: <20241017155516.2582369-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241017155516.2582369-1-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:408:f6::33) To PH7PR10MB7730.namprd10.prod.outlook.com
 (2603:10b6:510:308::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7730:EE_|LV8PR10MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 393bd34c-bc7c-4086-a24f-08dceec42bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oiOQvpbkMoimlKiombIHbsN8kmu0u0ZgII+7Q46FA6SX2ODNj4mh5s22Op33?=
 =?us-ascii?Q?4zUlbNdDUXu6PZ/ILz0Bq2bgmledFgm7wepQ+OUZ/AmtuWuPZ1ns3aU7VDzf?=
 =?us-ascii?Q?b1rJJC3q63DXcQjI2ZNkWfIY5a7jjDtWLIJc4g5D2j5yTpr8bSH/fdEJvcER?=
 =?us-ascii?Q?wYxDFCa4Lj1bAQtbjot7kkPo4JvgIk3G5GaK5AAXY9dakw6CV+7Q6MmV0wcd?=
 =?us-ascii?Q?d6EI2Xh1kt/ldefpFmaWD0g3SKqPiavILWzidMjtFSUCT/BRDhtD4EUaDPz7?=
 =?us-ascii?Q?gv7zQC5JPV4IJLpmoF2FhTelJvREPtnrMxX9OxQFq30HPJi3uPt6Ak0oaIoq?=
 =?us-ascii?Q?Cw6TjueWXsKNRlATyfmpU/AKKSe6ibNLUe79GW1nYgF/x9Nio1mDhvqdWzSN?=
 =?us-ascii?Q?DOMqjylRVq/qWaT2V3Jt+FwTyahlmCDwR3YM6OIPYjky+9aKpf1pc34AQNzw?=
 =?us-ascii?Q?QpzQqUYZwFMfzuUdUBCnBIOJr7oTxvcDUJOWg8cvp34TLESCSeViWpPrNVwQ?=
 =?us-ascii?Q?iXjqzWtUW6tTxeCygXhQESrSJICV/wHXjVjJNFkxfGzKrnoEtw/tlnnbebk/?=
 =?us-ascii?Q?0dhMH9KC7aVN8oMW1UaR5aBafxH+gPHW4Z1mPIcTbwsXYluHS+DFlSu/XYvF?=
 =?us-ascii?Q?1CGQj6bS42ML3rsSwIIdII6XGC0lGktpK5FFW4CWJoa0Cx4FvZ/XTnTe+s2Z?=
 =?us-ascii?Q?Io3hBmRM9dvSGrEU0lLu4pWlBPBr2P3RZocp9WxYuO0E+4gNKnrR2+/dtSGO?=
 =?us-ascii?Q?5kWeDowbaFRkymG2kvYgpHiam33D/Ckm25mct2/KZWskhWHbzSE3wRhhDMI0?=
 =?us-ascii?Q?QCTY43OOA9Mhb+13Cv0IKzw9F49fcvNc+oLfy3r2HDZFW36YgnHJWtdFf2gn?=
 =?us-ascii?Q?Cx3mtMAWExXdRgQMaBPCUw0RPJvbqdaYrHXNXTQGtB2l1Xn8/uUUgSQ+Ycls?=
 =?us-ascii?Q?q9hPfQndEGpihJ38hI1JLkO91tlHUZR3q2Kq175Rxv5fKC35U3UborsIoVCs?=
 =?us-ascii?Q?CRI3e7/Z79V37d+4Q2cGmA/LXOlwj8FzeaizvlnBVCU/jgwQKi1S+vE4PBmX?=
 =?us-ascii?Q?r1LQdVZmsS2fRVU7ZaHmT3tpSxaxLiDhN14ix2XlkOXi6D77XjHjkMNtq3PF?=
 =?us-ascii?Q?WrYANJ/wXdM8t8lNBwoHKEFMPGMr/46VnPeqAPZLAR17ENP2f9AAHoj8ZjH/?=
 =?us-ascii?Q?W179BkFzw1CSJ3pEQrehXfug1XWOnR/G9YfnVofGPnIhwKC6SNvMKEa9kHXb?=
 =?us-ascii?Q?agLLdDkRnD0qxYvTZyWMMmTj2P/UukiJEvcaEisTNQcNo1tds0eiSmLILqN4?=
 =?us-ascii?Q?5uShAAUAOpfUaHjDlwOtg1P+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+MZYLz1h9wUBrDGOensMxWlE1GTOgl9wfdRAzY+SUX81xlJSbjO95bf90Tt+?=
 =?us-ascii?Q?RVz6lTibjDotT4s9CMOVw84WPeEt4Fi/oTvTieFENkNmXhAKX/naA7oGy20n?=
 =?us-ascii?Q?5IQ4jTMZRuZBtuNtmB3uNUIM3LWsgk6UVP8+wYmHGz8IBwwW2MSRMJxbYIU4?=
 =?us-ascii?Q?kQlXUj1011Ga4TWi8L3E2KXbcvbqLC3Z0Ttvx8hl7UbSFjnaf8cyjQ6g81sB?=
 =?us-ascii?Q?AZd6zNOPm+3S0wQF9Gm7+gcxChL81vLlEzXZP0Ry8bMQxQMMwO4ggKC8W5uW?=
 =?us-ascii?Q?C3pUW5VdXLCkuFfbXJd0Xpgasp7DLKWoB93LuvX2sSQawTx7mzWLuiLtPvwd?=
 =?us-ascii?Q?NNYEbysrJnxPWyJxF9Xa90sN0xwEXbH9BYsiRtOa7xh7wCQLcmRl3fdAZf9U?=
 =?us-ascii?Q?yqbq1WtXuvt/bXVqaeACVMjGhiiGmElNZtqYJCpZzouJD4wNi9BYy7F4UZ7h?=
 =?us-ascii?Q?rYqlnlIqJcCZ7f5XkWA1wNCNXpK/iKTEEOYogfKJMjBp+5ZJ6+qCJhYZEhAE?=
 =?us-ascii?Q?Sy/FFMAKQlb0cour8GGf41xKbznjDreIga0KTFOD6DeSMg1OrnpS2NoIKoXj?=
 =?us-ascii?Q?yPMh99YkHpLGbeQn0Ov4k5U7zmfMYqkcYe3PQWpyktZ4NWb70AWdB+iCuoUI?=
 =?us-ascii?Q?lrAlnqBjaUGMA1UrhprSloRnufbDHK2OdEJBtyvHUJAlhNJk4twdfSlwWG4/?=
 =?us-ascii?Q?MB99fZWHWwwDc8zGrEO1Sj5APfryPErEGJ27zJOWSsBdlYDIQbRxekqGZmUo?=
 =?us-ascii?Q?RK3MF0Ke35Xb8K73OUeXFLegD2tEg4eH+GcppooM60C+cFgS3/7knk1XDGcx?=
 =?us-ascii?Q?haHdKqvp6rj/ruZpOrq2jZ1CeunKJYsz80QuMaEiOkBGzkohH6c0x7JsG1OM?=
 =?us-ascii?Q?aVj3I39H3NcOyuL62bxTY1WVmGTMVENmuncYBWfIExS/vaGNjByprzzjq+LD?=
 =?us-ascii?Q?7Ifqncay05uMW/TUfhEAUCjsd0Hm6RRmh6X2RUviSGjNlpBF0JPJZP49LuSO?=
 =?us-ascii?Q?cJ83f/bTiFYmsJ1qcURU9I4FjX+8YR4AvjhGSois2cdu+cFVwJWbNsPrELr2?=
 =?us-ascii?Q?NPHNZLSOMWNCa2yKah5J5WYpN4eVucJISrGss8M6Nw/GE2KeTn8I/FHxAhxL?=
 =?us-ascii?Q?KPeUjSyCor8vGdeH/k4Fuj4rF1ltf+Ze8SRg6CKwkDptX6SwHjJJ7tA7GrWm?=
 =?us-ascii?Q?LRikUWPMovfHCYqc2GETK9/vx5IgT5pJ3RKUu0viDqqTN272/FjINJCAjLR4?=
 =?us-ascii?Q?z8s0+vvQMeI8L9rcuc7G1LJmwtzE0slwkEnklXNA4KtYkUb++fWtFVum3cqr?=
 =?us-ascii?Q?C32HMk0MXMUckMm53P2a7ZC5TiJMFvcRR5tL17xJGfo/IdWaxmvxLrGJ8oLB?=
 =?us-ascii?Q?FFDDJmWbAs9BxPcPKAZra3QBoygv20OwaR8vt9Jm5dyzXQjX7KFJONzpsYUk?=
 =?us-ascii?Q?g1vP95+8Navz6ET4MSB7uETVQ5b5Frpd7HajjHlyv3jguiQNDxeDhHCMZumr?=
 =?us-ascii?Q?2UT3EddpeUthxuaJ5I4F5utokf7WMJf9zmc7zCggZhNrmyW3wZt/DRSkNZPL?=
 =?us-ascii?Q?Ewl5iVxMG7NRsA99lijXZk69C2BHZWXdIY5Jxb2JCiWdCV9fYy8CLeasLhIk?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9uV64vVqPOaYXjNBEjYZ2N1wEhOWuijzlE7KQQ4JSs8hbM+k0vPXkqf3cxLlpJDF/vNtNuCEG6OlSGjNmcN0antoqr6iX0JROzl6CzOxC+29rOjKHpSPAe1MNUjhJZxgQcMSTAr+jNAFQqDwxHarrpnG5B9+BIH6+0HfR6WwhF/RLeBfh5GMLnMEZ+23MzrrDaOC5QVggno8gaUGBsmzWFCC+Ige/KpN3WMszOdP1CGCef6Y4tXrmZw1at2+mTWoSafnS2EXgulP7Sk6znJhQyiMye3kXJx2774s1XNInjgSUf1eG9QJwfan/2nhyLdN2frk9AOdRz22ckucbacgZuNkKC9lePVSamYpCq270ZE8O6/LQINOziKI10efLEx3zwVPpVHKqhj9lImpKPorUKB74HoREtaj4C7kvjEsJxMTu1r4ZpakbwlQHmCmNeiLL9cdakPzdZHsU0Kzh4QJ4Iw8wCPuTo+yYTpow6ccx9xQCrbjUqTiawz0j3mzn+ULceiX1b9eVTzJQHkpGzIw3whJaCa/4VKuA3vTVxHChbg+xLy4/yme1VUh/bOlX3PxL5zxjhK+2RXgax5BIrWbEJE230GL5L/hT/xS0PYGVHg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393bd34c-bc7c-4086-a24f-08dceec42bc0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:55:49.6484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOXI1L3mMGCP9AMNVBBLqT8S4iwxnGsauUTXeed7HuPYkPpmINulkBqqFFqmBWH01UpxEFGKKVFVkezBeWrYft4YMKWSPPBIk2Fy+1OicNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170110
X-Proofpoint-ORIG-GUID: -0bA1tdLcYCYW9gxiaThzpzhYQ0wmLXk
X-Proofpoint-GUID: -0bA1tdLcYCYW9gxiaThzpzhYQ0wmLXk

Add a new verification type called VERIFYING_CLAVIS_SIGNATURE.  This new
usage will be used for validating keys added to the new clavis LSM keyring.
This will be introduced in a follow-on patch.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/asymmetric_type.c | 1 +
 crypto/asymmetric_keys/pkcs7_verify.c    | 1 +
 include/linux/verification.h             | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 43af5fa510c0..d7bf95c77f4a 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -25,6 +25,7 @@ const char *const key_being_used_for[NR__KEY_BEING_USED_FOR] = {
 	[VERIFYING_KEY_SIGNATURE]		= "key sig",
 	[VERIFYING_KEY_SELF_SIGNATURE]		= "key self sig",
 	[VERIFYING_UNSPECIFIED_SIGNATURE]	= "unspec sig",
+	[VERIFYING_CLAVIS_SIGNATURE]		= "clavis sig",
 };
 EXPORT_SYMBOL_GPL(key_being_used_for);
 
diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index f0d4ff3c20a8..1dc80e68ce96 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -428,6 +428,7 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
 		}
 		/* Authattr presence checked in parser */
 		break;
+	case VERIFYING_CLAVIS_SIGNATURE:
 	case VERIFYING_UNSPECIFIED_SIGNATURE:
 		if (pkcs7->data_type != OID_data) {
 			pr_warn("Invalid unspecified sig (not pkcs7-data)\n");
diff --git a/include/linux/verification.h b/include/linux/verification.h
index cb2d47f28091..02d2d70e2324 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -36,6 +36,8 @@ enum key_being_used_for {
 	VERIFYING_KEY_SIGNATURE,
 	VERIFYING_KEY_SELF_SIGNATURE,
 	VERIFYING_UNSPECIFIED_SIGNATURE,
+	/* Add new entries above, keep VERIFYING_CLAVIS_SIGNATURE at the end. */
+	VERIFYING_CLAVIS_SIGNATURE,
 	NR__KEY_BEING_USED_FOR
 };
 extern const char *const key_being_used_for[NR__KEY_BEING_USED_FOR];
-- 
2.45.0


