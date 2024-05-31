Return-Path: <linux-efi+bounces-1089-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC4F8D5720
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 02:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7794B1F259EE
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 00:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D335EAC0;
	Fri, 31 May 2024 00:41:43 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AA34A32;
	Fri, 31 May 2024 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116103; cv=fail; b=lrSKGEowzX6kZXS7wsejEX94aiTQGLxtPF/WH2FDV1i7L5/PTPHlE09cuIgcGs9OUleK4b0kx7BZH82QLt06Jf6NYnNErmM/GhSm8KdwMHEZ4i+AUO7QDs17OfE4Zy4GMOEg7iBTAZVAf87L4y8/IBE3/J8c5eoDKEvB4L3sDjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116103; c=relaxed/simple;
	bh=ou8g1fR7tppvZPMKuEp2405tNPF2nleOZqyzyYtg7to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=atee0+tim7q6uE5zudEguLwloHzMUUfGnPdKP5GF9C2rtjhw6jkHrczAj2U0M9bT67mSa3NMLGkAXk9Yxxc2Sh/RQsYYbqq834ieXoP7gqHkhxPi67BIPJSG5bIgZERTUovVVlZ2X/axq6JcQLlC7xuC0NmQluuNhq+PoeRhLV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFUkap019783;
	Fri, 31 May 2024 00:40:09 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DdXo7ah+YtGVwttXVvKOu1CBhy+nK5wF9aNOwgMh6hmE=3D;_b?=
 =?UTF-8?Q?=3Da3xn0g3voOpt/zuU+jDtbfamRdP2Eot+ADlBDFRWuotNH1wd67Ihjw5Ir/yk?=
 =?UTF-8?Q?PFi6+0GT_XI7q439f7Na4lJoHniEKPnshegBkmF4RAmIiZvaG01jO3AHEQX/2pZ?=
 =?UTF-8?Q?xQChX+Q0HbEdrQ_8o2s33J9LELR4z/zYYlcgkVWrMsdC+/q9T/RJ3QFADhPGc8n?=
 =?UTF-8?Q?Q79pkWtuXHsVhX3Fv8+o_+k8uZnjsaNMO3pkjYsS63RcbPBxHj0lxnFAZUswgRN?=
 =?UTF-8?Q?C2Ihtdv/vFrGzlTzGTl6t0Uiuo_Ci5VZk+R1mVpm1K/MpxLkGbSPWAtoRlGe7GJ?=
 =?UTF-8?Q?FVhqGb0w+Y4Bn9yJKO9rExCPGLNsP7ph_3g=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9tatb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UMEg5b006320;
	Fri, 31 May 2024 00:40:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yd7c7pm0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhNDXxCAa1qdihKkyQz/557+GDg1mc99CE7nbvZpwOGh56uczxrqCWZHOJ8n/PV362+o4sm60nbl5YbHO1ZD0TXjx/jo9UpbNeJOGJ/3HzwEzViSW4yNHyJw5pfMtA0APiM5clCX4+GFefNlHfRXd/XOtag7bHqmjGC7MXUpQuehBjiMKXvgIsTsy1UYxHpePY7cnmhOBvmBwJWMTd55V35OdMspmj8M8ZXtiqLfP5TaSxcr/nbWuaPXvfvN10UAdyO2hVeBGVAXB862L+IBrX9knvuCFK6p/clhJT1B772S6ds/j1QyzyYBH/4v4lqaP6YQKFhxstuk4+pq9Jeh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXo7ah+YtGVwttXVvKOu1CBhy+nK5wF9aNOwgMh6hmE=;
 b=HoMzdcOuRJlLNOBxWawoVo5JJzSE9sH5PEZCdROrRq7JY6U+SdB7JZn06rVYzn/oFLQ7SLnfr7eVksvpIJ870ZKY4/KFuVi6m2D7joZjCUS1QFNhs1czNWjGKPfxB03ZCohHt6Ge3x6kjMArz3jAUbU38LVRNKwxtAipBjRdSVp/pH27+XJoAppdaI5fXZvUvRZcE5kjZ38377izl3ge1P3BfgKAcGw/VsUxTGoFd9mKF6yDAYIzzxpbP5QWX3T3eahmstlNLVrgStDF9PMZ0A6DYfZyXTajsvFrgb6tHGPMsxzAWhg0weET5VAcqW3wVKqlSKb7JZmO+tFU9moq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXo7ah+YtGVwttXVvKOu1CBhy+nK5wF9aNOwgMh6hmE=;
 b=TxkiFbJv4cBYF7FZApGnOR6uZMVzp5FLC2gwoqemZoBuTLhtK5feI9uee/LnrSDJUfvrtBqWVjuDnmWYMFUdOHAoRuJCj+xUEq11m7UJE4bHmU9tACIpT1vNvLjFHk+33Y32DdX7WTV5aDNL5SUO+oFLr6rUNz+cHy3KrLckl6c=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CO1PR10MB4785.namprd10.prod.outlook.com (2603:10b6:303:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 00:40:06 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 00:40:06 +0000
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
Subject: [RFC PATCH v2 5/8] keys: Add new verification type (VERIFYING_CLAVIS_SIGNATURE)
Date: Thu, 30 May 2024 18:39:42 -0600
Message-ID: <20240531003945.44594-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531003945.44594-1-eric.snowberg@oracle.com>
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0591.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::13) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|CO1PR10MB4785:EE_
X-MS-Office365-Filtering-Correlation-Id: 026e2932-e2b7-4bdc-f811-08dc810a3760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TyZzt53DOAqQUQmT9IvuxKI00WNLD2TInpYjo7LhISGeMDESJzI7TpbpQG66?=
 =?us-ascii?Q?wmjm4oUQCy9J8aUF8stgNPt12FB3FuHrlWdG2FM9lGb/VnmcIKHHnTWCXfKQ?=
 =?us-ascii?Q?m1WKOLh6MT/O+5bhZ8ce0yM7bCi+FM5s0JYpB+mW8K+5CnQ4IFyTqLdmcN2P?=
 =?us-ascii?Q?cMAi7+8ICLQps2XtuvvdHeMwsysJr8oMRTKDYJkWQTWZHvYMocFR165JCmwy?=
 =?us-ascii?Q?wZM1kwXtl8q/ePHG3GRzOa5UoAJ2qqTZwWa9HD2y62iv8KLXTdsxAipJeLjo?=
 =?us-ascii?Q?kJlYGpF8b5r52sLku9wpTo0yFNDwpnYBPkhztqgbUea7XhiImFt5f8yEwHiD?=
 =?us-ascii?Q?/iNjv8ME4zNj+c38rkHrV3MN9S6QF5QVspsZgmyWByGUsUGZ76iK9izA9Tm/?=
 =?us-ascii?Q?0Fr/F5Zaw7ZKDHrekkGn8BdGHH/XZD2FmmY/9BsWwVru5QYPBZQM20k/H2g9?=
 =?us-ascii?Q?AINxRdrBnRToSl4SbcQ4Y0uUKS1DC5GgLE7O5KtXImurMFDWZvJ3ofbVecep?=
 =?us-ascii?Q?F3QWUOqrcWDeYtOI9WYldMVOPWSOfRBfIO7n1ene4XSMsSN7SmD26L94SE6G?=
 =?us-ascii?Q?XeITMy9jYYxDhSjjEfl+24hFo4OUQ4KDpUyR63okg22vwTEg9QBlKSHJDhDU?=
 =?us-ascii?Q?3SDKjXaBUr+JOyNlpe+CV0iSP1NVHYlPNxOQLxsn0DBHkei4T3xfU+TmbYMu?=
 =?us-ascii?Q?qbeIaJ1CvgHjkNZRYJVpJl9jaL6kQlE+j5T11+tKlzejEFE6Ow25YgCjrIt6?=
 =?us-ascii?Q?j1yKJ1A3mSMsC3MRQOM5W9LPtSHxew38Iujcg8C8TXM77lOKS2IO5JjzQ3ld?=
 =?us-ascii?Q?3o8wRLnSTWVrL54QCUFhR1PMkw5jUGJKdYBDQb1z4P4HaFNswiTp323CtHu5?=
 =?us-ascii?Q?bQFmPGXGjUKOPWg8ToYcrAJYVkRtmosPtLUYZOvrmRA4m/uuhPufxf+pWDRW?=
 =?us-ascii?Q?whWY+F/cvMrnnFXrLTdnay2UCN6BQBgt/fWOd1W2FlwITZpOoIf9rzQAbwoC?=
 =?us-ascii?Q?LcyCensJYBbP3UrhKS6JwciPXaG2xViN36LhqZ+US3xZ129GDYOKk5JiDkO9?=
 =?us-ascii?Q?mh7BgSlx1NffYOOHoDbpcwO0luDaqIsZHibhYVxIFq8mHeieoZ6bOvBOHME0?=
 =?us-ascii?Q?zAdXj+dTUrgdaPQ5pLZBDhhm9SRuwBZ2rBAxNrbzlRUxmh8qJrDBpjpdW052?=
 =?us-ascii?Q?DvKxYvAK8MF2D6XRfztOOm3iWw8ROAgBzGkaWNWLpltgodNOo147Mk13a1Ma?=
 =?us-ascii?Q?FEMRoeXRJwGDdPjmMvBDTx/UVlPT5ZBDMNPEWFIKIw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?V8nDKT1JuiR6iWyIHUB5Cdrnw1oFffMS6b4WcqN07vicP48SPZDXfB+2GRZW?=
 =?us-ascii?Q?BWOkXbNKhlJVTgT0XswOHEiGZCFjXxf6JY4B2MxOyIDlfNC5pbwoSJpwc6CT?=
 =?us-ascii?Q?kEmGOkpqiYIa0g6iaLMOf/SmBE2wXy5o+oIZzO1X6b0Yek5k1pbknqoTFEdH?=
 =?us-ascii?Q?OO4HCY5YhNc76BeMmGGF6u4cpoX0HI0Mt/kelW1eLJ2LC6gCuFTFdm2f9KId?=
 =?us-ascii?Q?DXG7hG2jfL6QHvV5EzvqdQKm0T0ETUlip+GbuJWfLrIu75W7d6FUq50L1m8s?=
 =?us-ascii?Q?zWlaxvMP1BTzND1RvJi+iE89jvdeQw8UfsL7/lrAFiUJ+InJ7TIEABP5knOi?=
 =?us-ascii?Q?wXzejADd6GuIJ2gm7rmBMap/cZ86QCdmu8J2EFgMvjI+ora5LT/p1dVkvWak?=
 =?us-ascii?Q?HRz0oSnEFFaoOJppdAtvKwtUi7WdfkZbYv2mmKPgy0fa0lxEYbkgUyy+dDE6?=
 =?us-ascii?Q?M/WtV7ZUyC6tYgh43WGTeUrrNJaZdkVp7ynw6ykNF1swn7kQpqlyw6qzAe2d?=
 =?us-ascii?Q?t6ienk3DwBPRagHsX8lzj9Djf912bAU537Gg34GgmgZE/Lj6+7G0uYtOTaJc?=
 =?us-ascii?Q?oh1j5h59nSNfAFpaYtaAtZmomOjL358GKJD/Z+AKImNcyeMg8edmk4vMLQhL?=
 =?us-ascii?Q?3e7pgCd9BeQel6l6Z9XLfc10gBjhQpFUhqW/UB0HB1MaXWsnZUd53xFmni0t?=
 =?us-ascii?Q?Kc2I8g3v8hk4FfKEPbhzsqYXQn9mln4VagTgTjGo+31XsfsD2sa8QSSBC449?=
 =?us-ascii?Q?oGkPe+b3ppJxGCvQQ3gLtSZ563MPcf0d9Ca3S/tpNWfdCK66LbJsFaVQeylC?=
 =?us-ascii?Q?KhLB8U0TVH9wes5waCTtpk6HT1o9gnYnIKTxJ6St7Qd4rNL/JCsSonZqf2CI?=
 =?us-ascii?Q?Z7G+VWrQSNAgVmrXdomjGWAfmlCZ+O7FmMmfEFivCzuWcWdlGnfQmLA8ceDs?=
 =?us-ascii?Q?u48ufsmSIaq0khc1xsMZyANu4YS1kIo2Q+cC7vWyzlrdfgGZ8sxx56sbVaE8?=
 =?us-ascii?Q?8f58PaZCoGFs7WJRv1kGybMyk1PcYFENh2lKUCIsG1D3k+diyhoMLcgvFY9N?=
 =?us-ascii?Q?wOlBqR07KKLCBpIaeAn8AK6TIBeQut0E+LgTwdwXswWF71cmUyyHewcVzsPY?=
 =?us-ascii?Q?Duc120Lt8IDDpDG0/gCMX+kaNYwAhqxAudYQZRJvJzT9Tz02H/+8ZulTp/PY?=
 =?us-ascii?Q?8YxHjpcjZ3T5crP9gQuxRCRqclS5glwWR/naYMAVexEsS6RCwjhkEkEZGczq?=
 =?us-ascii?Q?MB5RW0bKIn5WQOBi73PTXB7TaaqQXy+5JYuPBsL86z2OLcThmRjnNfg/1NQC?=
 =?us-ascii?Q?G+ReQLD5tHiWirFeiNNzVsyMoVnarfgckz1aqgO1ajZ5Qu8R8GvS7Vdx4Ein?=
 =?us-ascii?Q?V/0CSdSatZp+74utXhttqVMeiyv2/ayMPRF4kmAnW8PSgWLKCCIbskrTeGYG?=
 =?us-ascii?Q?UGy8YeT2npu6VEaAZNvlVHBdf4dRioByced7yWR8qtIJffsE/137/LYpTrYx?=
 =?us-ascii?Q?YAQG6Ao7hE/Exk4aLcV2XQ1382Eci8e2l7kT64WLeFKYE2RCb+L576f2Enjx?=
 =?us-ascii?Q?Artjnk/pJLSjs0QLmU+QKXgEa7yhMmv0spaYH6S6TOrXspZmLfRB8/smUI5J?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Yq/W15xiiMNz5+j+6D26v4MC9vGp2a0Ceifk32T0EOMJLRBWLvkY2PjWWtUle3pIly+nlG0+WwzekEXCUSbHVpS8LRTTY+SiqZ5Dv1rKC16JfFxXaYVlD2hSVmEz8ItQOoKwPqDuHT3tkVI2sHc2CNqWEjRGgL0CHUeNrAEHNX68VgWCxw2oV3zIWCd4nf24NiXnV5x8s5R9vFe6ILG2G51QtHX4L5Wxfgpw81DDhoi074pcYqCM6cdcUqIjxBf1+NEcsM14ee91OihamhJj0xD3Gy7v4CEckSfyfCNL6pWTjTB05tezPAs+F6i0Nq5AT2t7YHdlxpPrEpot7XkAjIiLEm2LcOntaWbPLP/Y5w+i63KEYn2e9IQKfb/4IBes77LuDDBtkzAvFIThtW3Wrkc9Rg/SUipwvDRie9AastdIqg7hL+2GAf09T8B9MGpBJLw5SWqWT/CPzbGrsjsybLrt2b7MSLvyyiy841uV49D2t2b88B82No8VB9EL6xignKggEFLyEbFGh7bHXXuf6h6pCBLT3i08m1d/dmWcRfj/IpGL1iAXYvmJ4ZweqUKX9snmSsXIV5CoOdu6z8moV3nCKBA/j1sTmUEKBH4oAuw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026e2932-e2b7-4bdc-f811-08dc810a3760
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 00:40:06.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8Xy8QiOztJIHvKTIuGh+Qbf5E7hbreoRNWVdHsHO/qAA1ncrAG0jMOsp0euJuhtPuZlmdNwyIvpDHMPDEDZiF63k+/CXhjsLKWe0XA/K4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310002
X-Proofpoint-GUID: CBaVsG8IvjlCZYKq8KLJkBMPKz63MoGq
X-Proofpoint-ORIG-GUID: CBaVsG8IvjlCZYKq8KLJkBMPKz63MoGq

Add a new verification type called VERIFYING_CLAVIS_SIGNATURE.  This new
usage will be used for validating keys added to the new clavis lsm keyring.
This will be introduced in a follow-on patch.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/asymmetric_type.c | 1 +
 crypto/asymmetric_keys/pkcs7_verify.c    | 1 +
 include/linux/verification.h             | 1 +
 3 files changed, 3 insertions(+)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index a5da8ccd353e..7fdc006f18d6 100644
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
index cb2d47f28091..970f748b5cc9 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -36,6 +36,7 @@ enum key_being_used_for {
 	VERIFYING_KEY_SIGNATURE,
 	VERIFYING_KEY_SELF_SIGNATURE,
 	VERIFYING_UNSPECIFIED_SIGNATURE,
+	VERIFYING_CLAVIS_SIGNATURE,
 	NR__KEY_BEING_USED_FOR
 };
 extern const char *const key_being_used_for[NR__KEY_BEING_USED_FOR];
-- 
2.43.0


