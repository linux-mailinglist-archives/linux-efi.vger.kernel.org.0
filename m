Return-Path: <linux-efi+bounces-1989-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578A39A2798
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 17:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170CB2845E4
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 15:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7111DF989;
	Thu, 17 Oct 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a47L6yVj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="alulh14B"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92041DF72E;
	Thu, 17 Oct 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180612; cv=fail; b=TJwfovB0Vc+zBmye480omkYCrMhmN61xwr8/+zkTUDMJuewyK3fWBpjeACMeLx9FT6+mRfcJrPVWm/fKLRE+k6nZltt8GBouoTdgBIHRsJORaG+WeFaqntZqAUx3D4S6nH3x9zCWHcbs8GYXR3jY9hhZT/hO228wO4x4Ft70xSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180612; c=relaxed/simple;
	bh=x/CcI3fQAAd0veGAxEafJSDwns91EQsfiQZpLj5XPow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Slbvaz7DohpDD7RcnO1w5A2CHvZAY/UpBGUxqY9HDxBCt25i7sf77WnDkQSgsXkanuaOiDXFOIaj7o1TXUx9/LZvlf9JxaEoYD1AipQs4jFmuf4LUfVoeEyWRbHnC9Tzm6oSCzMPF5mPdDl97sSZQMUZQSEcycCKRjD8e6nHlKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a47L6yVj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=alulh14B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBouM002189;
	Thu, 17 Oct 2024 15:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TZx36VR1eQTgQmDSXLoJmgghs8JvzuaCDjMBl3Kt0VE=; b=
	a47L6yVj3eZkX7PFEP+6QtGyL89opTol9dQMpX+jUS02NH4nAg8lHonpfPZrpBGr
	J1sBPV1JZH6OA3ppMU30b+IJju48Vu39t440jM7aqlLkRUOZy1Je2NL/UchLDRaN
	SZG0fiYzB4NXsPP1W6qa+T2L6b2yn+VtDzdSArgJ8XFMVEHhlgMS+ZyWghhHKRdF
	seZK92Meiflnl2Jn2jS7pgnw7HEvh5i7GTnOqv2hmlhTIu5osBGAnZSOI/ScLb+A
	UEesBo5bluCh/ZIxDlPfbof3g5yKOXRE+JPk92F4cpoWmfofvOdHTliulV8EQtAT
	p8EVSZYLc+wJTLJ6OE29Ng==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2pxf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFojgZ035993;
	Thu, 17 Oct 2024 15:56:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjgwp92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEpBGFBpeWSe1sk35BB8SHl4qJmR36hEbad5igKVaJetsylVT6/dae3ioHJNb8TEUc0FJ7gnAt+lbL2urcS5dVKgS6ArZ1ZaacYbHcaEKeE+5HHu6MsZiMxJmwgZ/IdrMIprWOouLJUs0+5recBoxm/DnodhduEL0v9XXMoKYwOYzrKHH9h+QPIr9zBNWR4kTnH4oZ3Ht7YTR4d0D+wADMQmZiwQpxN0gpuUrPA7pz3y/3uAm/we6N5+4NoCGz4IcV3jMd+nXVlQ1Ntnlk5SZ+KeFq53QtvcTHXGQjboKLjjxUgPSxzJm2YTIzapch7PjEQpVw9VO8JvNW1mP6mrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZx36VR1eQTgQmDSXLoJmgghs8JvzuaCDjMBl3Kt0VE=;
 b=Oqdk//fMMemA34dYZbTcwxtDZnljK7CJbFmeeXUcplXuXUU7QMzryyB9V+mNMZSeNSkXx5vTprO7mTF1wzlEg/TLe63THV4PjWOfzdNFJnIrqFseIJ+eQUEXR15KGMdPzOvuX8TzXblOFvkMRTrUggUhiUZO6k+6+boDEGDyHXGKUC0lo/IULRTeFnHP1xxZ02CpoDwPAUG1zUIbVlq6Fknxje6Dnue1A7T8BeEQNyi0CEdwAJCs1NQ7XEjfDlNHjzNMiQbnUElUyYq/3NGiN9GyWEHbvxQqcvDAknF2RmB992luzl9/EAgwWrRHie5Cd9CCPCiLDTwpVVAuI9fMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZx36VR1eQTgQmDSXLoJmgghs8JvzuaCDjMBl3Kt0VE=;
 b=alulh14BwIZtvmaODe9Ch2XTIBL1ew14Avl/LNip5D7z+1mGPspmROBVmw2fEN1J1D5mGxla18DVeVkN1DGNOinXHbLNphwfbZ99/WJzASdxwf/UxE1UOm6lNTmW2acyF0AIXSQZeA8qFA4wye1fm7aOgF+Po5xA0DDFiMP088k=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by PH0PR10MB5846.namprd10.prod.outlook.com (2603:10b6:510:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 15:56:10 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 15:56:10 +0000
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
Subject: [RFC PATCH v3 11/13] clavis: Prevent boot param change during kexec
Date: Thu, 17 Oct 2024 09:55:14 -0600
Message-ID: <20241017155516.2582369-12-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241017155516.2582369-1-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::24) To PH7PR10MB7730.namprd10.prod.outlook.com
 (2603:10b6:510:308::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7730:EE_|PH0PR10MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4c639e-9797-4e9b-91ee-08dceec43810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xCn0BZQd1wQm6ine7lxE1QWy9WBwxUE7JDSXIYFiFHMt3q/MzEyFwuCLDMVf?=
 =?us-ascii?Q?4SgIyZwTwsimT1tIse8qirnV9KkLLQjlondCpgZ4OxgMS7KawYfagTbfhf5O?=
 =?us-ascii?Q?/lFPduQchKNrpgC/9iAQBCqt4x/EeYz+/1cBE4EiliYQwv8Br2O+lCFeohdV?=
 =?us-ascii?Q?HG9YE2+7ohes1RibJZuJVNmkjtT4MnFQJ+cViebcDK4iuT9iODfJGthgX2yx?=
 =?us-ascii?Q?SvV9vtOr5ieHL+5qt2rJ2JzxIqrfJuorxNoYP6t88F6ymuyHSTM9JaLxkJJX?=
 =?us-ascii?Q?zLTTv9NXDd8QPtPpaSvtYABfLdBsrzQMhrxkoqosPOayeIR2j27SU/t1NR/Z?=
 =?us-ascii?Q?JBzDvJe5bZz0s64v8MoVGJY4QgjlAsoZI/UI5OFfCeR0KIZX/n5DVwD82mtz?=
 =?us-ascii?Q?gqeccaG0WNNYTO3yNIO0VMFaEmAuLCeqHsAfJd0tbES6e8lnt8881AePgQMX?=
 =?us-ascii?Q?XT0EZuTEXbifvAuhj9VH79pbPWSBGc1FWMd5Oyc41x/K6sWvH6q8qp3PhMZQ?=
 =?us-ascii?Q?kKSlbcIbxyEd/Omw8thdZk9VcjnIf8rjfLkRTcxhHsstStVmRxhMb2IPGJVx?=
 =?us-ascii?Q?xrPY09MlebjUrUVRcj6icOiRLOve+9KSXwP29xipoiIDfWCv+jFQwb+1TOWa?=
 =?us-ascii?Q?8dwPvv2cp4NUuehN+aFQYSxROtd3VmOlderWbww2G5u7PJnAcdOazi5POWIP?=
 =?us-ascii?Q?3rL4sCtg862/yZp9vnHLkUPBbfx3hPGkcmlC2UqYv8y9zwjZ38yP63qI8L78?=
 =?us-ascii?Q?U9+6PmK97IL72kEAuBQFanlnsy1clAj9AQqido6U8c76Q90r6iHqlsVr0Gy5?=
 =?us-ascii?Q?ebrf3zafae4I/2jViqhA3/PfnisZYKxSV2xJinxJH/554QEAZ3b59ecfAXIj?=
 =?us-ascii?Q?5nbohm0TML5yQOg01hLtS6hg6zp3ZMM1tLgrU29+Y6reCpr/wuhPUIoUbxiI?=
 =?us-ascii?Q?FuOHB1xq21MVYEmzw6NV2kHFKNIC0Di/RnvybwTybEhoxNG1nTYbvI2VDT6Q?=
 =?us-ascii?Q?B15oDZ47uZLTZdhRuHudpgehpJA3OEO37Bd3NrdpLqla8bMFaHW3YQnmI+RY?=
 =?us-ascii?Q?Z7kn9rSt1vIF6pRD7QKYJSUNfYHFd8ko4wbVAguRFHFJSWYXu0GhSMCSWs4p?=
 =?us-ascii?Q?vNbrMPUIdgEz8KAUpWUMIupS1mbWUyW9kiF0i9zp6PZKIs/lkdD6RS5zi8gu?=
 =?us-ascii?Q?/huqmDVJVgu5/Ln7txaEQAGLJ1QlNZ9lf6oE/nMl9yeI1r70vNbpZXWXxPEX?=
 =?us-ascii?Q?hpfnzXhbaOlFs1NfWvy8ZylhdOu8ZoDBDyQLglVWxWPNKSIMkWxmuSbZhvi2?=
 =?us-ascii?Q?8NM3O1mdO61CVJ7kv9ddgPqt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jn3q+zMgokeiAcqcoK8xrDPj8ERlHnjV9zIVru3Ex+Me2IPwZS1NvlDloamZ?=
 =?us-ascii?Q?cgsGJegXTgL2m1E2F1c96RBIDXmGMBrs7NuaW3uCDIk9gjDOP+FGPGjflW98?=
 =?us-ascii?Q?cW5xBsOY/ITT9gtHlCSoNXOQj4UaZKy1c1NRq+tPGHoK713nzbnTkE228S19?=
 =?us-ascii?Q?JUlI3qtpgc1TkS+PVWY6SGyJjCPUZMzQDqv92oDyOsVzM/3n3COWzER6uYbj?=
 =?us-ascii?Q?3uzJ1gvyWUIEuzjU2VEnirjgtN+uEgPZHkuS1gHBTt2nR9eKFAo7kzPA3Vfk?=
 =?us-ascii?Q?CoOGY/39ms79E82a/ushzGOFvSEVhskfO0NSrDhlpK5wgThd0RV8havvZUAO?=
 =?us-ascii?Q?aQU0TmoC6ZPOLFgDXeUhb9idzj6DeMjJcKa40zy2BVn/vMM3gg8QsATaBruR?=
 =?us-ascii?Q?fXT/BvWNJ132xacPK1ohFdEAzmbCj5moypZ9VYTJ0mt5KvdL4QqTVL3/orx2?=
 =?us-ascii?Q?+cBLwPQof/Ud75qVHyke/+Z8wB1Q0fFIhpP6VNE5s3CcopiUY2ewHA2vFu7+?=
 =?us-ascii?Q?8ybtZJhup0bDY8JyccVhLOYdA7/8IeCyqCxAGo4K0IZSmVH53HteYskTKtd/?=
 =?us-ascii?Q?yDn5kNAxBqUiIZtVGY7ZKq4crcYf4eK2R41eS6jmH9IueUrFaZOyuf6gFBFJ?=
 =?us-ascii?Q?W6yNXoMl0J8JJxHYJb6EY6fE7LQDNJwr7tfJENMuNhFYLv05ou/PsWvE44jo?=
 =?us-ascii?Q?1pc/Zd/wbMKH7UH4LrmiKdN+TTjy5P6VJv7VFw8marG6ybnXptZ2WDYQoTe7?=
 =?us-ascii?Q?jxlSuEOy7Mcphm58xzBA0GLEWD2YmD4sath9El1pMy+EhRYxKJ7sSbdhu6iC?=
 =?us-ascii?Q?YfHg4AkTQIrtpLNU9BOmA128rq2ov18kdDC3hqRfOqroJsQVMFg3JzgEhqC8?=
 =?us-ascii?Q?ZGASROPQBDP/Z0UaQ/YnCVOCiU0xx3dFUdELFqMPCceMTLYZB7jF2LJh5C4L?=
 =?us-ascii?Q?Mnuhl+49LjKKS7HkT00igy408NESUOG6cnx2xVVoc9OQudQAeUIJe4kEOKl0?=
 =?us-ascii?Q?jQzpDWKtcyQHXotNKxBqCvS1NzP1WXx3y3dwzgoexMAE0D+oi0RNkLkSCWIF?=
 =?us-ascii?Q?KJn6smaf/0T6zswFfPpnAypzAi6EWYWy0aofR0UMIjyUM2n5Uia2Vrhky1le?=
 =?us-ascii?Q?DNRWmDFtzdvkD8fB/YNY7Zk2Z48Y3Y2CUBYW2Prde7u1UaaJRYf35q62Rwa3?=
 =?us-ascii?Q?Xk5eEW7tlbvFeAC/CW2v7G3sT9rIK5VaH+aiTXseNER2VS3J2h5pDHXRsajy?=
 =?us-ascii?Q?Th+nwtlTOLXXbImJL4mfKiwuEVN64XSoaWcnlVTsQtdU6QcX8yijVulPii5q?=
 =?us-ascii?Q?eGZ+tUX1bMx7B93TBBWraB3+jEgJ1Njb8/om0vTkt7BtCwk4251FRgVzISaQ?=
 =?us-ascii?Q?OvpO0la9dm54coNiLWqSxRoD6V2E8H+ZFtflRAT8SdvuUIzQK0GNrPWfDQ32?=
 =?us-ascii?Q?D4ftXhAV+1jnbFBP6iSZ6rVxxjvt581GmVumylpbApDltOy3LiFpnzxURLJ8?=
 =?us-ascii?Q?sUL4Uw03dx1mAmDrxm9WBd8Mb0D1UIrl6siuKBBf4Qom+QQ6KEiBWY2PEWZq?=
 =?us-ascii?Q?bMPBpmOX9FHLlJjnbBbcN35lzZlgzWMpHkrStn+LwNP2yFYzinpnRNFIZY2p?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Re9ueWdUbkQFSmthlVdiuiK297JBsi4O6SpfGSUj21InSZu6E9Yqdd75i8MJ5pnSxQuvkdHitcJEKkIfRggMXRTHbd5fW9ZGrTpnPv4sjriZuqxU5mLIzX5zvBlHAprPPviKRMHofNqwWjWp0ztY4+18SU+Ln3TGNCBZraw3QGUk1PhE6Zua5aK6lt6aRXI9IrprvLrZ4C+bkdpokJXumvcC0Ts15vNyW88T4kD/39930ZYDtW703mfz398mQBaYUhx23dPN4OzM0GEF1jK6cqbANEq5TsCEenD7gYVnhk/x+AlainH/xLPsTNVvMR/K8OVIPY25JZvtOACLRAPMmiZPu/JWsfVGUvD9AJyoZX/gEdqDvC1pbemahXrkApsL51WOVc8RId6qIv4aiGityoIbnFpOer5d4x4bQMHnNUcG2mLt2PH4RNJi2BASkwbINS1+HfuoKG5hMW/ksRF05LQYdaQ4S5SGyuZy51ZvL1Qv3+lnZNxBHdmEBEAYgFAzFIM5ruSjdkeI1wiJqoIg7uCzT2LyS/jHufKEs6yMZ0SQye3yJW3rp+SgIRrU6xGz0rQIMC8HMbX2gKwofmgQ94D6fCHvFqaaTVjYLHVWx5A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4c639e-9797-4e9b-91ee-08dceec43810
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:56:10.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHG5Omhetv3C/5IDn2FwWLNH09kO9C68VV+IceG4Jkf2XM60Tqh5ClyKs8q4P7QS91ulYtNZvV2SsAEUcR7t+S2sRzi3xmoAM1ZIGqFnrsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170110
X-Proofpoint-GUID: zFFgjQcA91m2kxyTRujMxdgUPjYZbqUW
X-Proofpoint-ORIG-GUID: zFFgjQcA91m2kxyTRujMxdgUPjYZbqUW

If found, use the new Clavis EFI RT variable to validate the clavis boot
param didn't change during a reboot.  If the boot param is different or
missing, use the one stored in EFI instead.  This will prevent a pivot
in the root of trust for the upcoming Clavis LSM. If CONFIG_EARLY_CLAVIS
is not enabled, the Clavis EFI RT variable will never be set and
therefore not used.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/clavis/Makefile         |  4 +++
 security/clavis/clavis.h         |  9 ++++++
 security/clavis/clavis_efi.c     | 50 ++++++++++++++++++++++++++++++++
 security/clavis/clavis_keyring.c | 11 ++++++-
 4 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 security/clavis/clavis_efi.c

diff --git a/security/clavis/Makefile b/security/clavis/Makefile
index 082e6d3c0934..af68a44a0cb4 100644
--- a/security/clavis/Makefile
+++ b/security/clavis/Makefile
@@ -18,3 +18,7 @@ $(obj)/builtin_acl: $(CONFIG_SECURITY_CLAVIS_ACL_LIST) FORCE
 	$(call if_changed,make_builtin_acl)
 
 $(obj)/clavis_builtin_acl.o: $(obj)/builtin_acl
+
+ifeq ($(CONFIG_EFI),y)
+obj-$(CONFIG_SECURITY_CLAVIS) += clavis_efi.o
+endif
diff --git a/security/clavis/clavis.h b/security/clavis/clavis.h
index 7099a517b111..6f68b560311e 100644
--- a/security/clavis/clavis.h
+++ b/security/clavis/clavis.h
@@ -24,6 +24,15 @@ const char __initconst *const clavis_module_acl[] = {
 extern const char __initconst *const clavis_module_acl[];
 #endif
 
+#ifdef CONFIG_EFI
+int clavis_efi_param(struct asymmetric_key_id *kid, int len);
+#else
+static inline int __init clavis_efi_param(struct asymmetric_key_id *kid, int len)
+{
+	return -EINVAL;
+}
+#endif
+
 int __init clavis_keyring_init(void);
 int clavis_sig_verify(const struct key *key, const struct public_key_signature *sig);
 #endif /* _SECURITY_CLAVIS_H_ */
diff --git a/security/clavis/clavis_efi.c b/security/clavis/clavis_efi.c
new file mode 100644
index 000000000000..0d9c392f4697
--- /dev/null
+++ b/security/clavis/clavis_efi.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <keys/asymmetric-type.h>
+#include <linux/efi.h>
+#include "clavis.h"
+
+static efi_char16_t clavis_param_name[] = L"Clavis";
+static efi_guid_t clavis_guid = LINUX_EFI_CLAVIS_GUID;
+
+int __init clavis_efi_param(struct asymmetric_key_id *kid, int len)
+{
+	unsigned char buf[64];
+	unsigned long ascii_len = sizeof(buf);
+	efi_status_t error;
+	int hex_len;
+	u32 attr;
+
+	if (!efi_enabled(EFI_BOOT)) {
+		pr_debug("efi_enabled(EFI_BOOT) not set");
+		return -EPERM;
+	}
+
+	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
+		pr_debug("%s : EFI runtime services are not enabled\n", __func__);
+		return -EPERM;
+	}
+
+	error = efi.get_variable(clavis_param_name, &clavis_guid, &attr, &ascii_len, &buf);
+
+	if (error) {
+		pr_debug("Error reading clavis parm or not found\n");
+		return -EINVAL;
+	}
+
+	if (attr & EFI_VARIABLE_NON_VOLATILE)  {
+		pr_debug("Error: NV access set\n");
+		return -EINVAL;
+	} else if (ascii_len > 0) {
+		hex_len = ascii_len / 2;
+
+		if (hex_len > len) {
+			pr_debug("invalid length\n");
+			return -EINVAL;
+		}
+		kid->len = hex_len;
+		return hex2bin(kid->data, buf, kid->len);
+	}
+
+	pr_debug("Error: invalid size\n");
+	return -EINVAL;
+}
diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_keyring.c
index a4a95a931b50..81bfc3ed02a3 100644
--- a/security/clavis/clavis_keyring.c
+++ b/security/clavis/clavis_keyring.c
@@ -307,9 +307,18 @@ int __init clavis_keyring_init(void)
 
 void __init late_init_clavis_setup(void)
 {
-	if (!clavis_boot_akid)
+	struct asymmetric_setup_kid efi_keyid;
+	struct asymmetric_key_id *keyid = &efi_keyid.id;
+	int error;
+
+	error = clavis_efi_param(keyid, ARRAY_SIZE(efi_keyid.data));
+
+	if (error && !clavis_boot_akid)
 		return;
 
+	if (error)
+		keyid = clavis_boot_akid;
+
 	system_key_link(clavis_keyring, clavis_boot_akid);
 }
 
-- 
2.45.0


