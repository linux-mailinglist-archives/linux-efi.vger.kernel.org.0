Return-Path: <linux-efi+bounces-1987-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2889A278E
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 17:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618F11C25A8F
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869A1DF746;
	Thu, 17 Oct 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lQTEbwYJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="phRzK1H1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FD517ADF0;
	Thu, 17 Oct 2024 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180611; cv=fail; b=IZjcvIl27DSRi9kB+NWdYITbfKvXAHyqvIRFkmUTujtogJNxtcOtsZ/ETsOGc+S4cjymhtzaPdIERrkL2MRFCxj+Ikj3aVogCN7Y3H5hZJKUmbvdExsne2cF8qwSxroHr3SJ/N1QTRRiX1vr+1wLdPGqAOa2BkFRIAFcpzGFlPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180611; c=relaxed/simple;
	bh=eyyBNzo0pPajUy0whW5dmTHjqA3kTsJhoGhziO81ea0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dx3k2N7saPCWf5WdD8Ak4qEL/dxPiW9YgMzSHAixAzQhrmOipurg3kL4IR24lfdkwydv+vV4LL8CdLiQguGe1mlQF4b09EhnlUuxYffTVXrWGWaLTMOpLlryP6ugtVQ9G5sBOghH7Ap1/xt09UBNDHudT5C4rusaHb5JjYC7W0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lQTEbwYJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=phRzK1H1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBtIK029045;
	Thu, 17 Oct 2024 15:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YDTqhqPCXyUy/wm9cLMQ4hOO2UFcAO1j5bz9KsOIPGw=; b=
	lQTEbwYJq9fI0iUTX5NRe/4lF2XXUNOXyIILBIVS5CDtgtsHhcvc2olegz3VRela
	UScN1L1LFxBb4HgdlgPMdgrNVzyLjdupMU0kj1S+1OZ3qGZ8irpTCEyWH/BeWNhd
	p034GEWB+/xaHAxj5BClKa67EH/zAxXGcLDocBX7oTGTj49b3QuI3bdiyN23H8qU
	2tZrz7m2g63cjfAS/hUUr5ePWsHYfyIgAUXkCmZLL+v4YskpuXUgkUx7wIuEMRuk
	JDgzEC7BNmPXXOmIDIOuCShZmzfGvnmSKeMaPnYaw+2mTz1tZXM+eKT/dz8l3Hvw
	7crhgT4ZAcQfET9i2saBgg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt6tdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFPSY6026291;
	Thu, 17 Oct 2024 15:56:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjaej31-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkGSmrwvQVYs9KcazK+7QegfCQkE3MeTpHdJ4NFEv1QOfYi3/pHeA7HIYub1OSVdlnhRtAl/a8AZ6Yy3IrIWa4R5i2nfLzTE2Wnn0QG9Rx3GNP6Ehag931ce5Ls0UUtBNpcXtkDk/GGFzFMNNo9M3WVyDuJ3uA3VgX8eok7YnNT+RZhnyR35hEmBa/Bk7AG4QIlnzESxfFHCKV86DUC0FlTfjrOTf6dOdvdoe4AoTLgm8Xtf19jZ1+JmqcwxDTL4oik4LQ+EpDCEOuBTVt1pdCq8P/pQcN+vfVItrIA1pDKywJ5eug/YZk1VIx5tsux1VDC6/IfDslK/bNCI+bhkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDTqhqPCXyUy/wm9cLMQ4hOO2UFcAO1j5bz9KsOIPGw=;
 b=yqfjr9UTSi8c3XyMYeB3sEQtLMQqCFZ2pBS4Er75Ti2skzWRSgXFBQoY5QbL/Jl7DuCa/9UT588S3Yz60alugCG6f5HMxFvlnR2G+bbKiUUOaz9NdmLkkd/RUVZC5bO/viUNr+RNwWIMhIDBw7gP6Eh6xdaCUoNvR8q8HtK4dRtCnyScPRYpxVGniVTa9gMyUCzUXPDNe3lqNxDE9hooIJ/ezzF6k7SCpKzJTE4O8nPmHYUfFP8VJh1okHN1x/WSFZDxLbtUkC3ivS1jarEeFD2mM1tOIumQEntphfa7TrzjTLl83kZKSIt7lk1n5QqL22HXNDiqD8Cu4VHG+Z63nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDTqhqPCXyUy/wm9cLMQ4hOO2UFcAO1j5bz9KsOIPGw=;
 b=phRzK1H15sNUAc31zerv5Z75JRyBatgZC/k4tUVZlKrTJ42QvYMzWePZptTw5pL1fRKWpde4muWqtIIBBMn0I6q1S5qSRdk89vX/2zc2Vpu5s+5tplMHAXWySAzbaPgWEhFW4PEkYWG2vZlWrMJ8U5Y4PdzHxHvWlGjmJfhGyf4=
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
Subject: [RFC PATCH v3 06/13] clavis: Populate clavis keyring acl with kernel module signature
Date: Thu, 17 Oct 2024 09:55:09 -0600
Message-ID: <20241017155516.2582369-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241017155516.2582369-1-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:408:f6::15) To PH7PR10MB7730.namprd10.prod.outlook.com
 (2603:10b6:510:308::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7730:EE_|LV8PR10MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5b3e12-26b2-427e-6f34-08dceec42fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i74Z9ZVF1C8Q12ZdxDS74B1oMuDPgguje83QqSLNb3juehnNQtPxFncOo+Ty?=
 =?us-ascii?Q?t/R2CA/u+8v2TquP1qJCruz9gD0dHJp/XE22zaJIcqgcoBxgxQV7J03MLKAu?=
 =?us-ascii?Q?xyHoEsXmsYpVRBPKyVjXLRQS60a4Jd1j0fx0NsI4MUR4gaFAdHzreJ7tBq0D?=
 =?us-ascii?Q?FEr5VJ8Scf6vhpxxsNFI1sMGylutLZW3Mg363umm5bD3xfDEEz1REbvhqU/T?=
 =?us-ascii?Q?NydoDBwX+kQh5GTguXMyhVeA54EEtXTPX3xhp//jWkuf62D8eJxi+gVpVaVr?=
 =?us-ascii?Q?Qmh/CFvBsRNbTnYzo6qzBPNatL+imSKnH7zo0liyndaSZnL748PiekPG4hQq?=
 =?us-ascii?Q?HJjdT2QxSx2H8+CTp3lLnTgbCSthi2e3DCWmpMnn+IOCd4tRULljPFftJHtX?=
 =?us-ascii?Q?KR5ZWb93wsP49crvyquHyQzrroQV27dtBfekmbYXgPC+gwvWyGLg37E5XR24?=
 =?us-ascii?Q?2cRIMtxeMEm1XpDehBgZjxeG+xA80cR4xBbnVPp7tPKyol7aEPQvppsvVlWQ?=
 =?us-ascii?Q?rIlpdilhsqcjj3iFdPXFdur58NQFCX6t661zlKFDA1UlbeaA6pcE7Y/CsVsq?=
 =?us-ascii?Q?+xBJkMYoeBm1TCn5xKjlHkziO4Md2AleASB6Ekl6L6vti78ghXELxlwvOFpy?=
 =?us-ascii?Q?Uy7pQbuvI4AI/06kg0b5n7r2cFh2QqPkFlM7u/ZnxDEIsQe8GbLqa+z/a6mS?=
 =?us-ascii?Q?xUMoFcaCY/G3LmotJx0xNNT86ZSuprV/Keu3FJhqNuW4KzKMdVY/iOiY9cR8?=
 =?us-ascii?Q?Y2DDyRvOCfwEL0PbMbiHry9qW2rZxlaeHrQHf3OvGBVoxLBnLzyEfo+Vu2V5?=
 =?us-ascii?Q?748DM7GAZPpNBhuyuOy0Bx//mtqCfbsljD8vdoQwirgHb8QiEloAS1ddh+Au?=
 =?us-ascii?Q?ZI7+eqlMRjFLfzpagdYmziZolWA8VvhaUvX8mH2yyF3OmWd7AdfKiAW0N+V4?=
 =?us-ascii?Q?5gvqXWRWmtntepleSnuxGyhmD7sR1DSeDTjLoHkzvsrgBs0SiT91dofbTOap?=
 =?us-ascii?Q?AxiJRu9815rIjGTbwlugL1DjHqMdu69guXthaMd3PLQjXhSldgU7HGUZ4Z0O?=
 =?us-ascii?Q?1aCUXl9nl7qBpEGIGHiLmOz40aGFTijWarjWh0cYbHI/a/y6dVklVGl3Mckr?=
 =?us-ascii?Q?7NfZ3xml+yemVb8pTw2voStb0tdmqiDbM++URAsuM+1ZyRUA2/uTWTDDfldQ?=
 =?us-ascii?Q?AKYIuGuzOdQsDVimryXAoiKqfX8Ph5stCJYl360TgWwb07CDCZ1nUf8QNq32?=
 =?us-ascii?Q?vq+kzajCW0yMT47tLGRYpz8GzF5cO5V/o4OdzPp42jr78fNITCoCxMxlxPc2?=
 =?us-ascii?Q?zQaWJT2UEiqJVS5PMMnHYQP6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/VYW8uLUJfGnx06HgE9npMaCESKiy5Mu/rWgOiV7vhZBjGC+bdh/RIYnNRgL?=
 =?us-ascii?Q?dzQFzHoZuXD/hbat/lO9oAUNGfV+YHlbCpB+4IRkP/CURFrkfFzm7kDEJMaA?=
 =?us-ascii?Q?mzwqaBW7J1PQvfKvvlQWnIXA6A+PNfMkaPKDGHQNpPLQ1YTzK+OysYxlxmBP?=
 =?us-ascii?Q?SRC3Irezq91gI3XHOPhGejo86wyW4mU5GRFlZFIIwtsfLbHgiUDE7tdycIrH?=
 =?us-ascii?Q?oQOxKFRehbhVr4dV73ADwkd3EeonuJXlGrZW4e2IqudP8bQ0kse9vkq0gHp6?=
 =?us-ascii?Q?DLARkuknjHJHBY4ldUpMGLl5UGFlON0JSU1DM8dhPzhqdkPWRKRpr1FmYnx5?=
 =?us-ascii?Q?jts1pVB85cY7EsHCv5q9PO2kB5DNydVSzqtbXRV0vNdH1I/4t1gUM8bFPdVN?=
 =?us-ascii?Q?4A7ur627g7VzO9hhHTioCZqtEv9JjRxVeomWTJjGuZeBobN5AjEahKfxWqsZ?=
 =?us-ascii?Q?IMR2o+Npllq9mZRtzZE6/iJGyi41F17hYXgRiJbc2ACnIuZChtDpg51gIwel?=
 =?us-ascii?Q?EKseF1tsfG36Zpvr3iVpOEW2I1CuWOKC0QK24dPM+s2ejdn7lHFslx361qFZ?=
 =?us-ascii?Q?o0lwID7WfdrQt8vmMDNYQ4gqiVLUybBxByVYtxerPqEJY4STxCEesmcVHzsP?=
 =?us-ascii?Q?D/ZaRMICwRrC7YA4klCVzPiaFLMKeBVfe8ag0+PtGxXr1vDYo4/LppfLMgJc?=
 =?us-ascii?Q?LqRbM6PY3YHKHovBQoMylr5y7164zGL6v3yVPUVqADRebpYd+cTfm8maYzW0?=
 =?us-ascii?Q?CDeP4QFq+qt8FalS4NCfUuSVWCtjXGi3+sqv1+zt+mU/lmT6C8XDsV29Rj1N?=
 =?us-ascii?Q?OEinGhUdSP3DN3R8qMJ4tFIhkfeQ2Kcpr+pyL75UybINZ+bYIDJprBfrIRik?=
 =?us-ascii?Q?KruutmqNwo4Xd4BSRfigZ2zuv5eTCmzM336tFw4UtiVTa/Kj9hojHVKMVhSI?=
 =?us-ascii?Q?wpdLLMuKun4t0rZkRJka8RrTY5zkotpgcLCepDdbD/ByVRNNf66XalJFgsdL?=
 =?us-ascii?Q?R0kdUOggcXTlHQemW7YY6XksBqQuYHDNMibysIRVgUHLbV+SeK2ZhokzGUKO?=
 =?us-ascii?Q?vv32Qf2Lks4BiOwGafNH4fl0U88DouKwiS9p1jiGN/s4n1J1RxJcB4id5CxH?=
 =?us-ascii?Q?l8re92p53yEOSW0hxVOpTxxgifeLCGYVhtsEj8D+9srnMtNI6avL6W+Rl2KQ?=
 =?us-ascii?Q?el3+qCxPH477hOhvg15QiWyoVUdUA3zigHljOdOpkbPJyrtSNEwHyXO0f4n7?=
 =?us-ascii?Q?nqhpQuHtt+5iUNBlQl63WxyrsTQwcpn0kI18PmaXmDVpyGBlEH3lX6noMmPe?=
 =?us-ascii?Q?BdzeecXL1vO+pcCa31FIi/7djJPx9gwdKkj7H3EaCw1u6xp3d7KYwR5TzGDy?=
 =?us-ascii?Q?ctrcREP4DwTPmhKUg4l6xSndRLwIx3OvUd6Ifg/ZbC2UBnFpEHqXafuRsZ6W?=
 =?us-ascii?Q?61lkdaRvjKv/SQ974w35LVTu+fEvYkLjjj42RmagknlZo/vAktfeS0SBDadp?=
 =?us-ascii?Q?YrXeN1fUdywJyf6KwFh971pVBKE7sfVYF2Nc4apyZ1bDji+W8PP2beoe8coI?=
 =?us-ascii?Q?Ts480v0fN5ZM0cVXoS3sviTpMNDJx5iZxhNJ0/SQLnsEy7LhOYhvpHq78eeI?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+njJf6xdaQTc6ktV15NtrFIp7S0i7nfdPX1vjlO1M/ZsC397E2ymTBBQH4iIDtCP6uKXr/BwX//Jy28DGVa7Z6w5pvEBsT3YcjAdQVU8qeQ4PUZ5I3XtuKEsGZN1E9i05ENk2P+MgKwm9IjXpTJ/REz8hkxNR3biDvwIM0ksyDzkwBxqCZav3Faoqv53V4ft66UDQyNCKJ+P/wglqLnsPDqobc7suX6fweGMOaLf2uAlYBlvFkpqasldC6DPX19AduK6LDmPwI2/ezleYlqeSKjQ6ld4T8lGDNmQH0IijuBRdv2Bo+Rm4oIHV9zacU5UH0Ci1UWsyPbJX6zr4QzR49G9kr8ME5yRDDA0QduI59Eh2HzGYmhZyXmLXf0NdX0HaK6i4HKO6ksXgdiCwa2KP4NHcUBM7pJjueo7ByUZo61DR6KS7F1SfOGhhtsEyAEqoq79H463xdNlaKYUmCnLYdhDUctk2f53SlhAne5wpKgwM884rPJBMnwk2VTptECn4j6t/bIjMNZjCFXTu8oJo0FL4GYXc8KACc8LqQsa7yE2VoNooaYmxswDdoFAmfl0ibJnjrkUAfMkSULc5Pxs11jwoPExmqF19+kmobDH/9Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5b3e12-26b2-427e-6f34-08dceec42fc3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:55:56.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0y9BX/zzQ/GqRj4C2oFHaT0wwAXvZKtMxvUmtqTG2EL7AYWQPhxJc33BF3DwzZ8opRWGdjdkcStrukBpFefUZKAXgbtmXSgoMiTLtPb5mbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170110
X-Proofpoint-GUID: T_il9mZ1QPVR29TU6khlVwd94ojBrhDw
X-Proofpoint-ORIG-GUID: T_il9mZ1QPVR29TU6khlVwd94ojBrhDw

If the kernel is built with CONFIG_MODULE_SIG_KEY, get the subject
key identifier and add an ACL for it within the .clavis keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/.gitignore                 |  1 +
 certs/Makefile                   | 20 ++++++++++++++++++++
 certs/clavis_module_acl.c        |  7 +++++++
 security/clavis/clavis.h         |  9 +++++++++
 security/clavis/clavis_keyring.c | 27 +++++++++++++++++++++++++++
 5 files changed, 64 insertions(+)
 create mode 100644 certs/clavis_module_acl.c

diff --git a/certs/.gitignore b/certs/.gitignore
index cec5465f31c1..dc99ae5a2585 100644
--- a/certs/.gitignore
+++ b/certs/.gitignore
@@ -3,3 +3,4 @@
 /extract-cert
 /x509_certificate_list
 /x509_revocation_list
+/module_acl
diff --git a/certs/Makefile b/certs/Makefile
index f6fa4d8d75e0..f2555e5296f5 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o blacklist_hashes.o
 obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
+obj-$(CONFIG_SECURITY_CLAVIS) += clavis_module_acl.o
 
 $(obj)/blacklist_hashes.o: $(obj)/blacklist_hash_list
 CFLAGS_blacklist_hashes.o := -I $(obj)
@@ -75,6 +76,25 @@ $(obj)/signing_key.x509: $(filter-out $(PKCS11_URI),$(CONFIG_MODULE_SIG_KEY)) $(
 
 targets += signing_key.x509
 
+ifeq ($(CONFIG_MODULE_SIG_KEY),)
+quiet_cmd_make_module_acl = GEN   $@
+      cmd_make_module_acl = \
+	echo > $@
+else
+quiet_cmd_make_module_acl = GEN   $@
+      cmd_make_module_acl = \
+	openssl x509 -in $< -inform der -ext subjectKeyIdentifier  -nocert | \
+	tail -n +2 | cut -f2 -d '='| tr -d ':' | tr '[:upper:]' '[:lower:]' | \
+	sed 's/^[ \t]*//; s/.*/"00:&",/' > $@
+endif
+
+$(obj)/module_acl: $(obj)/signing_key.x509 FORCE
+		$(call if_changed,make_module_acl)
+
+$(obj)/clavis_module_acl.o: $(obj)/module_acl
+
+targets += module_acl
+
 $(obj)/revocation_certificates.o: $(obj)/x509_revocation_list
 
 $(obj)/x509_revocation_list: $(CONFIG_SYSTEM_REVOCATION_KEYS) $(obj)/extract-cert FORCE
diff --git a/certs/clavis_module_acl.c b/certs/clavis_module_acl.c
new file mode 100644
index 000000000000..fc2f694c48f9
--- /dev/null
+++ b/certs/clavis_module_acl.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+
+const char __initconst *const clavis_module_acl[] = {
+#include "module_acl"
+	NULL
+};
diff --git a/security/clavis/clavis.h b/security/clavis/clavis.h
index 7b55a6050440..92f77a1939ad 100644
--- a/security/clavis/clavis.h
+++ b/security/clavis/clavis.h
@@ -11,4 +11,13 @@ struct asymmetric_setup_kid {
 	struct asymmetric_key_id id;
 	unsigned char data[CLAVIS_BIN_KID_MAX];
 };
+
+#ifndef CONFIG_SYSTEM_TRUSTED_KEYRING
+const char __initconst *const clavis_module_acl[] = {
+	 NULL
+};
+#else
+extern const char __initconst *const clavis_module_acl[];
+#endif
+
 #endif /* _SECURITY_CLAVIS_H_ */
diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_keyring.c
index 00163e7f0fe9..2a18d0e77189 100644
--- a/security/clavis/clavis_keyring.c
+++ b/security/clavis/clavis_keyring.c
@@ -259,6 +259,31 @@ static struct key_restriction *clavis_restriction_alloc(key_restrict_link_func_t
 	return restriction;
 }
 
+static void clavis_add_acl(const char *const *skid_list, struct key *keyring)
+{
+	const char *const *acl;
+	key_ref_t key;
+
+	for (acl = skid_list; *acl; acl++) {
+		key = key_create(make_key_ref(keyring, true),
+				 "clavis_key_acl",
+				  *acl,
+				  NULL,
+				  0,
+				  KEY_POS_SEARCH | KEY_POS_VIEW | KEY_USR_SEARCH | KEY_USR_VIEW,
+				  KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_BUILT_IN |
+				  KEY_ALLOC_BYPASS_RESTRICTION);
+		if (IS_ERR(key)) {
+			if (PTR_ERR(key) == -EEXIST)
+				pr_info("Duplicate clavis_key_acl %s\n", *acl);
+			else
+				pr_info("Problem with clavis_key_acl %s: %pe\n", *acl, key);
+		} else {
+			pr_info("Added clavis_key_acl %s\n", *acl);
+		}
+	}
+}
+
 static int __init clavis_keyring_init(void)
 {
 	struct key_restriction *restriction;
@@ -274,6 +299,8 @@ static int __init clavis_keyring_init(void)
 	if (IS_ERR(clavis_keyring))
 		panic("Can't allocate clavis keyring\n");
 
+	clavis_add_acl(clavis_module_acl, clavis_keyring);
+
 	return 0;
 }
 
-- 
2.45.0


