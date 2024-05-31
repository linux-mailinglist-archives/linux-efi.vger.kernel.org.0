Return-Path: <linux-efi+bounces-1090-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E42FA8D5725
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 02:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1107E1C2232E
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 00:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D881134BC;
	Fri, 31 May 2024 00:41:43 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835A84A35;
	Fri, 31 May 2024 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116103; cv=fail; b=gBSEfUDnqMobS937OLXn7cL5yG34u19NsJSZtzNjyzS6eogQ+0NLUBOGi4QdA+sKQbYYZigUrYZhbOKrdf3mo+jUAuXoABZ4+B3p/2EHGX8ZW5YRXW17KruFskPEwDY3qIlzaEg9CMWlfhK/caHilt43Mr4fMDlef2XP2KOguK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116103; c=relaxed/simple;
	bh=DlvA/E2nmcmS5xGecWd8k1c8IFxOI4w3YHhOPOyp6WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tq0fHIImZeBqZTqcN7LsU4Y4YdoPpbHJPwuuxygQTFwoSHfHup6GoV7OcHKEMGv4lPZTxYpf13ywHh1vQ6cleI6jjahQMRo013dJXpxfJ56yJlPj1PDls5bcHFdI7VgHzd0Yt3NIfq46Qx3DrWC5eJ873obIFM8xsUHmFrBLnjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFOGVq001930;
	Fri, 31 May 2024 00:40:06 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D0Om8nLy28UyHmr6YMUm1fRB69CMsmRI0/fB6KqLCaic=3D;_b?=
 =?UTF-8?Q?=3DOJJ4anwAYGbrdWHPYDsYuEx3xRL+Dqq+E4ogJVJKMV8MYa+LUt6vTi7mn0wn?=
 =?UTF-8?Q?vFwdXkyR_cGAtLAobqNHqv8Tls4Qq1ltbx0QL6QtLA0H36TRw7Dvz87ILmuFJdr?=
 =?UTF-8?Q?xJh/D9B9GIDLSn_x3xE7XO7Q7oIgUMZbzkGzYwbvP1DYpMBlSOYPkVgqrp+yOMn?=
 =?UTF-8?Q?nJJYPkZAh9sMm/wnhaFZ_Me2fNGHCjCUQ9XBQ3Ah96uZ+icw6IHg+f86KVGYo78?=
 =?UTF-8?Q?aksCfm8MxTTzuPHqbNYqJt7Oin_X+ShkIAcHBCXhArOYrgE1aaOEXHOLyFAVSxU?=
 =?UTF-8?Q?b2HenYx8+vqF76+qp/UTUu7DWVNM5QnZ_jQ=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8fcj64c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UMfwEu026627;
	Fri, 31 May 2024 00:40:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5098hkr-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VX6+1+darxCn3+pXXPgbubExsqLOaDSpPGmYsyWuzqpkF01lUu4c+tmPhEAqcjSaeHlRJLL7iiF7Ie+S7osUxMJew6pP6poQqoFta4e73DO7vf6WBihl8SlTBxEYeRM9Iq61O48gvcir1BYAKA7/qKTDvufo1hQ/7wrNJUwdUiXkH3VGxfHX7NHUiuCn/70+n+pbULGhgCR0SVJAT5w41jV0XYicAByFVZEqtxDBWFPw6PnE8UjJ7n6v1cCohaJH7AAPsng+C2Q82/gnAFpazWkWDXi1f8Z3BzA0SLWIDK5OsVBSyeg2iWkyExE5vV2Y4QwCC/YMwWg9qL+XfRlVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Om8nLy28UyHmr6YMUm1fRB69CMsmRI0/fB6KqLCaic=;
 b=cN+r76Y+TZIqoLw50ZxL7XB1H1r1H1XzvJcGERPdNhxPDMJkRcwLJ2AdmaEzGIe4wImsjS6Dy3xwBwoeMtsJ8AtoRhTKnm9Z/8bGWomt4txItZmURL2soY3JNmgTi+pTdD1UrcSv3Yv4iZR7E4Gy/ChzqCRnOKy+kkp+YxJHeZcplZEkMk/AVfZXJb3m5yuqMaHkuvd6kMhU6I4TMWnHEueZZw9/rIVZj1OHNLlfgC3AZUJprMtoFCfPtNzfTPrUArQZXtYBeU+d8YdgMKbg4YtGUOt2IKuhQ2T2DYsnpqEwZ9XtSj9s8DHJMQPFu2EkNLlq9VzALAfkywpCwF9HPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Om8nLy28UyHmr6YMUm1fRB69CMsmRI0/fB6KqLCaic=;
 b=rxOboEIf31ULuq45xJkEVvFK7RQibleWHf7BF42YXnR0lk1hfkSeCcoG+Qfs/AC+Tko8mha6SZ1n/AlAsw9l0Si046eK9VD4s0jvd+CxAzQ0MsKqEprg+BErT/T9Y0fwrAahpTTgXbGICx2JRrpPPkqRNjIAoemkcjPowiWT0qo=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BY5PR10MB4274.namprd10.prod.outlook.com (2603:10b6:a03:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 00:39:59 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 00:39:58 +0000
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
Subject: [RFC PATCH v2 3/8] efi: Make clavis boot param persist across kexec
Date: Thu, 30 May 2024 18:39:40 -0600
Message-ID: <20240531003945.44594-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531003945.44594-1-eric.snowberg@oracle.com>
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0031.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::44) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BY5PR10MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: d971ca9c-1119-4c3c-9bc2-08dc810a3328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dmWN0vGyisNCJVymIIPz0zYXDbZswqs81YhfvTx6IUdmLMiv1JtJOElECedl?=
 =?us-ascii?Q?bzSLCoTbKdkTXVsV6JVOpKWuyp6ubWYgquhsgjVBQ4oIwGBSFsmX71K0EzTQ?=
 =?us-ascii?Q?8dpxmybxvQMFHt/30/DcG5kmT1hahyLnZCNlbX9ZxZUDyQKkXLCjLAKKE/Y+?=
 =?us-ascii?Q?LbOgbg2oPJJKEr1M0tF8r8OvYIxpQUvMVzkZuz1WnyJCWcMcN58qSgnIy3rN?=
 =?us-ascii?Q?RlCmWrlf8+Q8NG25Xe1q5QNuwrUa8IT4J+FWDtFYzCy+YSFGfw8zd6GRNy1I?=
 =?us-ascii?Q?a7sgYFT2GFDr5kBZrWFPvZJmgVJtxXyfaV831APaiByUCXdfg81lajbor9RG?=
 =?us-ascii?Q?jiYK4mIOfbuWOgA5ZDlubCMshwt1T8V2XbJjWtOy3dRMajl1aXLZH6h8of39?=
 =?us-ascii?Q?SYu7mEXsnUf80KCwS51v6kns8Ejm7atcef1vMG08gZqjwGbzBQhV7aEtd9gr?=
 =?us-ascii?Q?PcOfg/+81FHji4yoojhGBS7GtYStA4VLZwmTq2hMbvE1dARxFLIvShENfqVW?=
 =?us-ascii?Q?664imu0z0LGsipFojoSrKA2sCIHPbKlH46U7ZoUMjkHurSe+zrNFdERu2U1H?=
 =?us-ascii?Q?+Ic95xm2xjUrxVVZQkZIpsI+VrY5V2ZRT0V+L9kqgHQunaBDmtzodoNHmXRs?=
 =?us-ascii?Q?vrVpO0Jzku4Kt1sZMb5MHAJdx4hjKtjh21Wc3Pt7O2RYf7Q8UXfnG0+PuQri?=
 =?us-ascii?Q?9gtHOe3LzIH7biAy1yKzh8Oakw3MxzUD55z1lswU0oSWi/0Ylyqb7u2y1zCU?=
 =?us-ascii?Q?7msSd1I/z9805wbF374Nsea5jVpBs5oIGGXyAe3HopEwaBqrRob1PkUo0squ?=
 =?us-ascii?Q?YP/v+EboNUhVMF4/w5YRWsX8mR+GMWPUk39DmiheH4GHi8iOZqbFMPpVUXIp?=
 =?us-ascii?Q?/JCXrkZd5/VuDiAQ6EpquZCPE+jRVU7HZ0EgvFo8u2ir3rk18uH51hxgt3Pl?=
 =?us-ascii?Q?Yfxktn15vhz1Xk2X4F0nstp54r8/93hYnTSRgw/s7zb2aj6rFHpsVEFZDM+s?=
 =?us-ascii?Q?k8l2O6X8ISvtwG1wFF81pVuimAZNIDUsnFY8tiBOMktX7TRcQvbpJb6zwFNr?=
 =?us-ascii?Q?kcU1AYLmVHd/4aGXvtfkAzQrmsbQZmCug2cfbYcRfBcSJpEtnLvKERZUyHqO?=
 =?us-ascii?Q?BYa1NBtEQZyKZFAwiD4dYnEtxBX1gPPjb2VXSekCM+JzOXu7FLCzjJVg5cSf?=
 =?us-ascii?Q?MpziJmhAU7LH/cuj1HSPcwjgTI3JMYZ4byN9MJTLMo4SLEr9bhmJegVUlus9?=
 =?us-ascii?Q?l5wdBMjGIl9WTbyRooAuAHk5a+X0VmocufGOLhP/Yw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ClYOcwfDqEXVuYRPg6wxYRrikJrX+BoCPDpUH8NbJvYh39bv7s2ysDr7Mzuo?=
 =?us-ascii?Q?iUoZO29sWe0o//OacLSvwhME1NX3KIUfS2dXXNhHiNFR93KJxq84OMx1Vb9D?=
 =?us-ascii?Q?/wtAutEIGIIlrkUdKEyu2LIDxzLvt43DY1mhGsZvwe22BtcTdThu/2ToaV23?=
 =?us-ascii?Q?Mr/ALbZf4uFoPs6eq6pcrcyIFsALoNfFe1HUvJRtjlsR9HQowCqbJ8Cr8byG?=
 =?us-ascii?Q?KOzfQ4JJgzBeyoUhNZjoiT3WZqCBWnqOlbh1IwQvOjWhV+KlQIQTWAr5axmK?=
 =?us-ascii?Q?ym+ywViD0qC4imiIz9b1mzunRWdLqfyP/BnwqRVOBEwo46EaUfrNyeKv08hR?=
 =?us-ascii?Q?3zynL0EqYI+evmgUmHmHsrVGTmNshZr9Z/0yWKANMP3ZF2VZuQ37HG9bUGJW?=
 =?us-ascii?Q?W5xnKvWtIVOGaJYYpYEImifASggoHeKShN8ffNbTkvQOzYwDPcUpZ86BHN48?=
 =?us-ascii?Q?6NVb4ZX/YX0h+00hD6eJVJZ164Zygu032wCDBeYsUtKWGodQSo98O3hgmr7J?=
 =?us-ascii?Q?/FQq/wgE3l82fuZqdIbdWuyuRj9/ERaC7sEXxGKbUhQHj2Tl0RCE1B40EZKN?=
 =?us-ascii?Q?mW6qiQkwK8JYCbHJTvyIdClLgWR9A19wDCPjiaHQ58W2P3sgYm50YHF4DYk5?=
 =?us-ascii?Q?kAYpA5hdZeoX8HaXjxcFGqD61JC878QlA3+dkxhGDfDpJOwVttM0Qbr3SXM9?=
 =?us-ascii?Q?KJqo6cr+VQMBQps4xinfODTYPh6TByxno8eEvT/61aV1ACXrjfOYPS8CokFx?=
 =?us-ascii?Q?AMajwAg3uFf8Gm9yfHH9uvoPE5egIfb6/JsUvkQYb13ZOw/d2x6sL6nfGHgY?=
 =?us-ascii?Q?ux84ja+hlW7TAagcok8vjS+ME6gDsIX1/Q952miXcLI2MuU65rd27kVNaetd?=
 =?us-ascii?Q?iMCUFE2mWjZQZQskS2VZOaCc7K2K52MvUUtR3dOWLEknUwWztxhBjmwFgs9u?=
 =?us-ascii?Q?Fm81cgNLhYf39FPU9rKbsf5AQKaBOHB0RssB/dWhnNW76fbx/T5FVe3Z4D2/?=
 =?us-ascii?Q?7TLLKON28SeKggsYkXWPU4AAsu2BhVf/bGo7Gsjpwei6oSpvNjdTs1gazIpC?=
 =?us-ascii?Q?uPNZdou6nPw1EX78vJBm7XugjQuSTFImmh2I9rsHyxvFCjhFAsrc6/gZsSc8?=
 =?us-ascii?Q?fqyMLNiJAclLsvnr0sLQMph/zBggVsCOmoCFS3VTBD8JVu8cQlLlgtgwcwSP?=
 =?us-ascii?Q?eRFqrkWxrxHU4d1M22ZEEsjGmxt4au+DM4PZw0uPBlmf3zuQbiUHVlsmPzYg?=
 =?us-ascii?Q?3BrouPbPBa0mqmHFy6mKlOb6FDiLyM96Uq0R2gJbWHtK0t6Gr0wFC5ZDjQlU?=
 =?us-ascii?Q?TU+KWSFAvzTGYXZhwanlrBSkZISzYjjjS4H4hCDWqQ5mbY4KMUwC1YINsVqr?=
 =?us-ascii?Q?BPOi1QQewKjNO9rD22t2WF6H3Lw02Eqgv4gE5A2CxZjfAzGmahuKjXvx/zFS?=
 =?us-ascii?Q?VsqY4UvKYAaIbHTkiEqz6nq1p7PhDvmNMOqr0piFsTdLxDXwElG/Ul4+M3bi?=
 =?us-ascii?Q?7IpHl3RizTmF9SeVJF3JN7XSH+oc3vJcc5/NgLfgUYES5HtzpFvshlxZB/9R?=
 =?us-ascii?Q?DI7GAtx7xl608yI5bkrRwB1sTSz7kFx7mkJ7hpzeAe3LfDnohb/TlqiRUyl3?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UWEIHULXnGAyyO0U0n229lGTu11y7UZCMU6snaGnwSWLiViWp5OilVFFNUlVzD+kC/W7Zd/MOcvK3wgcPSKAVUrFOu1KJAzH5gc/UJMQIeIHmCTkPGNp7C92Jv3I8NoQRE0IXPt8pCyxue+14Owj2kv5Nh5+qE6hIl+oH3ZMga3jTCEGKB9ZF5Hw9Fv1rVU+8xdOFpYduf1biIpuBP6mfdiikn1dQMP8l0ZEjTz9dGtnUbogw61D/dVbtIsa4ZnGNJlp8HIErCGFPFKjmwuqqN2KnesWOcdKaXcBMJ+bkcso0r+BxqJK32R/KQjfAbW1/kvSDaxfrQQyNwH2FbmFQI3A2+QXEyvDsfHA7fEFKbyJo3A5YgLuuz3ahtQbHVSGcJ0Lc+hsYE5KrJzQZECQCdI6eoCgjOqh89G7kvS5c4ee3M7tim0gTiogWs+bfA7cNw3oaGFe2b6fD+4NPCZjrA+fJIuS7dliTMtsbv5Ny78FAettCGMNE1reTqfer4z77vFCrw3mN3h0P+lWAkO7z6H9s1p00GAMhhmbv6smzS6JbBJlcEbLKszP6ETFcmG7Km7kWZxLwMml2+LeE8SLyNg6uWiUCfBp2xEs8O09D5o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d971ca9c-1119-4c3c-9bc2-08dc810a3328
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 00:39:58.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngGIFn8Cla4W2CsOpeVg417VbbEyIvxH+oST3NZGNbr02l3aC7qvH5vuDP9DhsxFvD6wh7eZMBb4XjGs6IYkzjyu9SqXKN/eGDS1OzTe1lY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310002
X-Proofpoint-GUID: bJzAoP1C6DrSybsYNatkBz4vE_yfYIJx
X-Proofpoint-ORIG-GUID: bJzAoP1C6DrSybsYNatkBz4vE_yfYIJx

Add the ability for the clavis boot param to persist across kexec.  This is
done by creating a RT variable before ExitBootServices is called. The new
variable is called Clavis with a new GUID
193ccef6-348b-4f1f-a81b-0ea4b899dbf2.  This variable does not have NVRAM
set, signifying it was created during the Boot Services phase.  This
variable will persist across a kexec, however it will not persist across
a power on reset.  This same type of functionality is currently used
within EFI shim to mirror MOK variables into the kernel.  It is being used
here so the clavis boot param can not be changed via kexec.  If a different
clavis boot param is used, the one stored in the RT variable will be used
instead. Enforcement of which boot param to use will be done in a follow
on patch.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 drivers/firmware/efi/Kconfig                  | 12 +++++++
 drivers/firmware/efi/libstub/Makefile         |  1 +
 drivers/firmware/efi/libstub/clavis.c         | 33 +++++++++++++++++++
 .../firmware/efi/libstub/efi-stub-helper.c    |  2 ++
 drivers/firmware/efi/libstub/efi-stub.c       |  2 ++
 drivers/firmware/efi/libstub/efistub.h        |  8 +++++
 drivers/firmware/efi/libstub/x86-stub.c       |  2 ++
 include/linux/efi.h                           |  1 +
 8 files changed, 61 insertions(+)
 create mode 100644 drivers/firmware/efi/libstub/clavis.c

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 72f2537d90ca..8dcb5326d05d 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -186,6 +186,18 @@ config RESET_ATTACK_MITIGATION
 	  have been evicted, since otherwise it will trigger even on clean
 	  reboots.
 
+config EARLY_CLAVIS
+	bool "Early clavis"
+	depends on EFI_STUB
+	help
+	  Allow the clavis boot param to persist across kexec. This will create a
+	  variable called Clavis with a 193ccef6-348b-4f1f-a81b-0ea4b899dbf2 GUID.
+	  This variable does not have NVRAM set, signifying it was created during
+	  the Boot Services phase.  This variable will persist across a kexec,
+	  however it will not persist across a power on reset. During kexec, if
+	  a different clavis boot param is used, the one stored in the RT variable
+	  will be used instead.
+
 config EFI_RCI2_TABLE
 	bool "EFI Runtime Configuration Interface Table Version 2 Support"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 06f0428a723c..4ceb055fc01c 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -74,6 +74,7 @@ $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
 				   screen_info.o efi-stub-entry.o
 
+lib-$(CONFIG_EARLY_CLAVIS)	+= clavis.o
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= kaslr.o arm64.o arm64-stub.o smbios.o
 lib-$(CONFIG_X86)		+= x86-stub.o
diff --git a/drivers/firmware/efi/libstub/clavis.c b/drivers/firmware/efi/libstub/clavis.c
new file mode 100644
index 000000000000..3a715e87a13a
--- /dev/null
+++ b/drivers/firmware/efi/libstub/clavis.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include "efistub.h"
+
+#define MAX_PARAM_LENGTH 64
+static const efi_char16_t clavis_param_name[] = L"Clavis";
+static const efi_guid_t clavis_guid = LINUX_EFI_CLAVIS_GUID;
+static unsigned char param_data[MAX_PARAM_LENGTH];
+static size_t param_len;
+
+void efi_parse_clavis(char *option)
+{
+	if (!option)
+		return;
+
+	param_len = strnlen(option, MAX_PARAM_LENGTH);
+	memcpy(param_data, option, param_len);
+}
+
+void efi_setup_clavis(void)
+{
+	efi_status_t error;
+
+	if (param_len) {
+		error = set_efi_var(clavis_param_name, &clavis_guid,
+				    EFI_VARIABLE_BOOTSERVICE_ACCESS | EFI_VARIABLE_RUNTIME_ACCESS,
+				    param_len, &param_data);
+	}
+
+	if (error)
+		efi_err("Failed to set Clavis\n");
+}
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index de659f6a815f..3c45eaec325d 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -100,6 +100,8 @@ efi_status_t efi_parse_options(char const *cmdline)
 		} else if (!strcmp(param, "video") &&
 			   val && strstarts(val, "efifb:")) {
 			efi_parse_option_graphics(val + strlen("efifb:"));
+		} else if (!strcmp(param, "clavis") && val) {
+			efi_parse_clavis(val);
 		}
 	}
 	efi_bs_call(free_pool, buf);
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 958a680e0660..c15cd0d9e71f 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -183,6 +183,8 @@ efi_status_t efi_stub_common(efi_handle_t handle,
 
 	install_memreserve_table();
 
+	efi_setup_clavis();
+
 	status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
 
 	free_screen_info(si);
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 27abb4ce0291..e43c4fb5aa97 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1142,6 +1142,14 @@ static inline void
 efi_enable_reset_attack_mitigation(void) { }
 #endif
 
+#ifdef CONFIG_EARLY_CLAVIS
+void efi_parse_clavis(char *option);
+void efi_setup_clavis(void);
+#else
+static inline void efi_parse_clavis(char *option) { }
+static inline void efi_setup_clavis(void) { }
+#endif
+
 void efi_retrieve_eventlog(void);
 
 struct screen_info *alloc_screen_info(void);
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 1983fd3bf392..9457fc531cb4 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -975,6 +975,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	setup_unaccepted_memory();
 
+	efi_setup_clavis();
+
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
 		efi_err("exit_boot() failed!\n");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 418e555459da..6887d4712c77 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -422,6 +422,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID	EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
 
 #define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
+#define LINUX_EFI_CLAVIS_GUID			EFI_GUID(0x193ccef6, 0x348b, 0x4f1f,  0xa8, 0x1b, 0x0e, 0xa4, 0xb8, 0x99, 0xdb, 0xf2)
 
 /*
  * This GUID may be installed onto the kernel image's handle as a NULL protocol
-- 
2.43.0


