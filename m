Return-Path: <linux-efi+bounces-1088-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345C18D5719
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 02:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5734A1C221A5
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 00:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EF5A95B;
	Fri, 31 May 2024 00:41:42 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10310A3F;
	Fri, 31 May 2024 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116102; cv=fail; b=rJAYNjsubuFKlBCAhEK0aW2pmcXz0Ujc2MBwWHfEPCPAI5eBf4XKeCuyhG/ySrQTm8Xll5oxpIKyZWqYcziDTyony3EzmY1r5tG6xtLlY50dThJ8P6l0FWRGMnm6O/KoZbWw93TZVJdAWJTTAVybMb2HAzG4SWZB1frsKZOB9gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116102; c=relaxed/simple;
	bh=fuWLNigJGiWMPKRRps2geJFw9gTMutwzxmoXwBEEjlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AkGqzGhxlFJogTIxthX6do2zi9RjYXjoZfYIlx9vZPWGSDJTHTnblvZCDbangW+ia2tSnIWW6DQWDbOThWw5CuZMFRv0mE10EhQFh6SYyNiOoJL3p570zSiyYJV+/0nDvV/M/EW37ywpaC3bWKQX8vJQlZL7TE3R2s0Br9W0MQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFc6x4005731;
	Fri, 31 May 2024 00:40:04 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DCMJG2C7kHQ0cDcQSto/qM9dJp+gobr2qbkHTuCkBK58=3D;_b?=
 =?UTF-8?Q?=3DYAQVxC8qVXVP1Co3ESiu+hoNfEDtJbvWjGQ1i6/o7eAdU49gHNDffmoycZe4?=
 =?UTF-8?Q?p78NH/kt_DJ+haBQx6MdNnLvIAZv4dyehsqFBpeY5bOhk9cRdN0xiLzVk5K+dcz?=
 =?UTF-8?Q?IeVCSnMwHRCvEc_FYun/4Gg7muRkmTZ49YNPa+shBLCiCahpMWtakbB5ryHxni6?=
 =?UTF-8?Q?G2U4bcviI6lZAUgOKilC_QfBH5iZLzlQdx5wLoGpc8qyWNB1d8TSv01ePaN8iwe?=
 =?UTF-8?Q?Z7w77fQy5hbDA3PPrWoOCoHa0C_05MtHxJYFHKr7A/70sZYmOyt+8RNYmrHJakk?=
 =?UTF-8?Q?bkJjxqCvgvJw/pt7JJO8balhWAylGXWe_Ug=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g4a61q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UMfwEr026627;
	Fri, 31 May 2024 00:40:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5098hkr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4khnpPTtrfEgNn9dHKuNwVFOSM4Ow+rfykvZ4Ue4TaA3Go/UEat+IVsNVHlEPX/JcdhUy7mlXrTqnfRpCr6PJeirDR1wX3Dk/zDsNRyiH2O1Tu7dlWh/ec1/vynmwEJotkS8852zTHCuPnEuzkmJLVyJvvuPovuaWSn7nUVGAWM/EowvSh/yYJFq0eymtnO9gOwNnBqrCj5R2adTR4ehtkOLl9h1VtD/ZeRlqc5QYegMrIPejTvv6Pldg6SzKDTuBpoBIk9QCZxXZzpRfoGC+IjCjfGenwbH8Qc0TZX11d7SyYrdI78WduBvnDGLLapcMtfSdFzV0r3ggrtIckxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMJG2C7kHQ0cDcQSto/qM9dJp+gobr2qbkHTuCkBK58=;
 b=XeaUTzU7kz0Kwo9TLy8YOCVImIgUelETU+h7TEjXR+5BgfDjyNnskMe+582hBPKs5sDbVEbt16l6Zi1ccRybUcJQyIcJMUA0mql3wJmOJfTtcqiLJ5jXUpkYa0816Wx6Ib8f151CMihgokfAWYtNKSu7LUAlbhgoKXLNx2eOSN0XLjIRupN49an3HPWbtaEkaQLhsIeNImH3qkeJpK7x74KmfAoUlf6dSKfvktojXUZpN03XT0upxhVx6Qidtv5rTWpuTwzmObxPTeEpyusCuOMsg5nrMsVytTMztfke/6OsbEI4brQ1HSBpFhA/hHsGTdipJJsO22efSy3FkwgEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMJG2C7kHQ0cDcQSto/qM9dJp+gobr2qbkHTuCkBK58=;
 b=lYoKhyIVUHqcjbgsmLlbWvBJThik77U2vLCW0Aym/r63rFMRPvsb4kFrOda25bWQKGKvlX5uOYzSn7qAwLEfe8OttCJNt9O8pId76+bUow8L48xGvQB5VS9bkzMCYLE71EuL8/REJmPh2QigEWWcNiKNH0B836QVY1tp9thCXFs=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BY5PR10MB4274.namprd10.prod.outlook.com (2603:10b6:a03:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 00:39:57 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 00:39:57 +0000
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
Subject: [RFC PATCH v2 2/8] clavis: Introduce a new system keyring called clavis
Date: Thu, 30 May 2024 18:39:39 -0600
Message-ID: <20240531003945.44594-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531003945.44594-1-eric.snowberg@oracle.com>
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::38) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BY5PR10MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e6d531-44c5-4f93-8f58-08dc810a3202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2/wFU/aijUrHHQbJXz0998PQ1m8z2IoGGfMU3FvVF794LimV2hnqr7QZlbG/?=
 =?us-ascii?Q?RaxRrHZKI6AaSqH8Egj/1E/n458M656Tefh5w9ulp+oesK1Rg+x0DHiQkBpS?=
 =?us-ascii?Q?FH+3Qbv/v1zbIiT9VLCa3nUf41ttQa5OFOJ/hJjsSqvtiCV+xCx6zpNCEYXZ?=
 =?us-ascii?Q?WT9ETzlzuwzXmmrmeWtq1AxaY1ffAU2xeCXMrgTDs9wuFqgaOJsEpvDkZ2t7?=
 =?us-ascii?Q?HV1p6FnIB8COpcnTFeqEgxiXYgLoieUbnqPyUzhTnVOn+COpfl4N+j/WTxby?=
 =?us-ascii?Q?tEhWBORWRBsMZF2h35Nzv/7kJflw2eLYk//+RdhbZcpt4eYeumOc5XiqXw2E?=
 =?us-ascii?Q?RXjc9XTnnu8pH6OFlkcjQ+ckSL2pEZWzZ+2gM+/YKgNpBPCGgecedxiADYDf?=
 =?us-ascii?Q?Qrr0yVWTUPwdkXlPVe/HD9segcAx/gxAAcpde/QGPdfBIvYH2lluvGlzQVAc?=
 =?us-ascii?Q?a80jSFSLcrxuEQEKcMT/QhqD9K1h6E63TSw7Tu2ZrgAaVYxHOHLDnxpCTSgH?=
 =?us-ascii?Q?m3DUzva43L+AA/G9iTpvYrb8WUhT9w/YbdoaxTWHNK8dMvifahJxER7LU9eM?=
 =?us-ascii?Q?ieMLCEVW9vTCLrQ/e/qlWyEBbQCpJHN2UaCOdDj7YwhcGTZVr95ykAwYDCdu?=
 =?us-ascii?Q?TJejzr/no/NibDq5T3teTkHHQKqGtao13kB/4U1Q9zTL87UxRbIYKQKRpzA/?=
 =?us-ascii?Q?3GF+MUb6YnzAuuxgkwsE2GAh1Gjlga7Xub9ZB9INHYR0O7GOuKKJLYU3AQ4+?=
 =?us-ascii?Q?/PotmY090UB1gTk/+PZkAzjEYlElmL2DVLDxc2O02ouDeEuSwiNZZVkQAp6n?=
 =?us-ascii?Q?mYQVqUArY3UDJk9PEVKccrFOwS+zuxuI4TmUWMdksH5DrnYeuH3uw/uyNT7z?=
 =?us-ascii?Q?dYIiVduwGKBIQTuTymODyRWWMzRD6oTAvRzs4Kv7gmW9RG73gYmOOZVxoP/y?=
 =?us-ascii?Q?gDSFToX5fVZd12df5UJgCq3K0bklmYbKReZthtAjFAFVJ/2h9tr7Nvvs3+zz?=
 =?us-ascii?Q?EX9bf6b3nXtyycnHl/2s7rHOC5VFvV3ViCUAmk1caS8d6b/VeQwDmSYz/Ye0?=
 =?us-ascii?Q?m8R31uTTT9mFOFW9A+OafGBpovgZo878hHrMbGLCDciNcEPq1AhdyHPKP3iH?=
 =?us-ascii?Q?uaVphfIs3bjDOqyp6TS2OI4Yg/8K2HzXayfB7FjmkL7DyeagsTA9Y7C2WJFr?=
 =?us-ascii?Q?Y+9xxiV7bGI9V8wqSFU9kh6bjq3OAYuqWwpxFjCa/LbKtfHI369+w3+/gV1Q?=
 =?us-ascii?Q?HRLF9Ldp2zMUu90hcmsqgfv7KgUA0EcB09+t/0um0g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+BbiMVPAf74C3csWw/Y+lslwfA7zvKOkRNyOF4HH/6qHAdW6SRMKMK1IM1YV?=
 =?us-ascii?Q?0wo/ZCgH3HtRTVU3PlPWOLU4kUmKMCLFLlu1ZZfPqSR3LLHv++BA9V+fwNXQ?=
 =?us-ascii?Q?1p6rFTCKPfMQggtgfGtG88dH/vYWaM2LEZwLhJyWr8FXsFkdpdV5q6Vz53FJ?=
 =?us-ascii?Q?ZoNWUx6qpqGAI5eKhAz5zbYFoc6FhGMjzyrOPTHxIn1VtZkLjmFLjZRon5Mx?=
 =?us-ascii?Q?tzDbvhEj9t4xE4G16WXN/mT+1JMY/bjzkYgZvEmeCZPAsnMxxYrgi8Sz+/p7?=
 =?us-ascii?Q?kOsxGUnF5a+ys2qbqW3uR+eXdkdbh/oABREJZOouRFSTppdQA5tTxNycLeo7?=
 =?us-ascii?Q?wLD9/zagvyFJ8/yQqEwJG/2AF2PqBczsnERNh2Wa6VDvU5HfmgoOmcSzIHjg?=
 =?us-ascii?Q?E5tvFAt/NBhs0wTgR4iIEE1azIGBEh+4h5n1tj/W/dtAnqg9SycCzdKQ0jtT?=
 =?us-ascii?Q?p+0AwFZjn2V+Ll1cyVMfM3IPBgMOCeyOp3qiyrcbSnA6h4hEqaeO45/fjs89?=
 =?us-ascii?Q?jCMQdPwpfJgCjKhHsiGlTC8bjV5FfHTh1nU0ha1LygC7fk/8Sb0cKv1zSaa3?=
 =?us-ascii?Q?K5orkguHTS+/I7+AJAYB/dhDqdvtuOvW1Ui78U7obQ3NAt/sTeKBbSQgYaO1?=
 =?us-ascii?Q?o8or97obCIEF2hN9Sll9zB5WPS7xPJTHANV3GaN5mNOKFAsySp73GgL+Ub+X?=
 =?us-ascii?Q?5bZXFkflTHL+2XoxXgO/zTxZ2S71A0sN0hsFIwWE6jrkPE7/3tgoEJEhwmhq?=
 =?us-ascii?Q?Ho0ESBbq669Ib+uuUNKrm2ykUTjbXqiPH3Zdp16HG5x0CwzDh7A5CNgKzAkP?=
 =?us-ascii?Q?tn8V1TBaTezoGkBX5royBKb3zHzB0y0S5dJJj3hpdm4297OUhRRi9oc2ev6/?=
 =?us-ascii?Q?B9oYBj5r75FEY3gVGRIM86fk12xOmOJfWKuTinkPiYtUMQuQPo6TIBeuFqGq?=
 =?us-ascii?Q?jvNWFDlW4yY2BLiljzKEYHdBoqb/Iis5iTEHgykzlMLYAx5hBjtgEViaUIZK?=
 =?us-ascii?Q?2Tmr8qy4+rdPPdTcdxxtutaMyt6oQec+GqQ8YkivRiOlki+9MTVThIiYIVGn?=
 =?us-ascii?Q?zbxoYKNi3/ZZF/uDh94imfl96UODKKnqjRI/1duVPaLtU1C9Xy+GnXSQs95P?=
 =?us-ascii?Q?gkYDXvxF2II+tsEAaT7VaFMqD1DWWUWFh1s/wMm5g8zJ6HPuDfk2x909qO03?=
 =?us-ascii?Q?pc3wgU4O37lvuRvvmtwL2dokN8toEArtxND0+Xy8TbyXeVbBMzGDFxVc2EMc?=
 =?us-ascii?Q?p8BgNghgoqKQ5Pibr7+A4CbzOqOfFuDl2DH4pWCX+Jvt/vxZynk7EhoVUWM+?=
 =?us-ascii?Q?qPw7iir1R4/vZsBCGRcltsojdgkX3qF0bWkoNDM95IZ3FykHz1p6ZTmbelGk?=
 =?us-ascii?Q?3nC0eFc7mynp0TP9kROqmalrhOYAhS8YhSs05g3EkMERTlQ15/Zbmz13fze5?=
 =?us-ascii?Q?5CSm/jTxpb8x/xN8QbjBk00fh5BJAxE2kjfoKWYIUcAsfm3TvYx4aemWsocE?=
 =?us-ascii?Q?IkEwFGPddJomX3RDfBSCms6ruDnRgdz/jHcaXAWs2YUQxoKQlyCCZNWwnJFZ?=
 =?us-ascii?Q?3HvDpngHh+c0jGFBPOqkKySPOnJ2rf61zJbif5UksuWCJdomVhoGZeqiNuWC?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qBvq3YTLJ2eBf8dnxlooH5PcDHxC6fDRdOhupSHdrXJbYDeqQx5sD/IG1ybi/do3DtXWOCZY6K5BS8Dr0t90C6upBbkQ002nlMG9+7dy/3DiMsMd9sf6q6AUicuUzTFnCgbBEXkydQVOLmq+zcBwr4Wcaly3Rnx1qh8fstoHcJxI9vElDEfdOJjuko3cCgaJILCVvtSwsGtBk5F7gEgjE7IQADPmReqnTtL3TVNz++KDPlHTWWeuNWBwBWCZ9wbO5iDwMnnW6ZZcg9hitGNC1nsZcHHyXPjq/VQXQSxOieMM6ASr/eiT0JDp+CUdOCUieOnXsj30h4eQOORIYYFzPNJ+g2ZZVfS4d8IHbJz7y0YgkXJcMJQ/ubook1rxZeDMK3S9ci1oerXfqjJE2jMMlue6q3KywDXxZEbvPESg31r+JzX1Ee4+Y0ldQyBWqTPdfXP7dEno1m+kJRYRB7RsQRH1oOfqJFrDnvWIkPozZ4vf20WlMUtc3bayXRacKstDbx0azDo+hVTw0YIFXypyYhoTTv6sv8KU6k9KHGdy37nz8P+TosuNcjOasJp93xzX7qOMl2ACgttQHxr7n+UiE6rVZtZiDHe51Mk/2UEU9yg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e6d531-44c5-4f93-8f58-08dc810a3202
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 00:39:56.9822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/PKxEsqgLsUF3mQ/OMpxtn3NgdVQUYv1Xi8oky/SqsGC9Q5ozxrEGELrN45FTl5PSzmYqLn4gfCDzOTzjqvqs6mmefOwfqD/0HmJuOmcUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310002
X-Proofpoint-GUID: z83kbeWcYAJ0bCo1pPwtInD1CMiBskJI
X-Proofpoint-ORIG-GUID: z83kbeWcYAJ0bCo1pPwtInD1CMiBskJI

Introduce a new system keyring called clavis.  This keyring shall contain a
single asymmetric key. This key shall be a linked to a key already
contained in one of the system keyrings (builtin, secondary, or platform).
The only way to add this key is during boot by passing in the asymmetric
key id within the new "clavis=" boot param.  If a matching key is found in
one of the system keyrings, a link shall be created. This keyring will be
used in the future by the new Clavis LSM.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++
 include/linux/integrity.h                     |  8 ++
 security/Kconfig                              |  1 +
 security/Makefile                             |  1 +
 security/clavis/Kconfig                       |  9 ++
 security/clavis/Makefile                      |  3 +
 security/clavis/clavis_keyring.c              | 90 +++++++++++++++++++
 security/integrity/iint.c                     |  2 +
 8 files changed, 120 insertions(+)
 create mode 100644 security/clavis/Kconfig
 create mode 100644 security/clavis/Makefile
 create mode 100644 security/clavis/clavis_keyring.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 500cfa776225..4d505535ea3b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -624,6 +624,12 @@
 	cio_ignore=	[S390]
 			See Documentation/arch/s390/common_io.rst for details.
 
+	clavis=		[SECURITY,EARLY]
+			Identifies a specific key contained in one of the system
+			keyrings (builtin, secondary, or platform) to be used as
+			the Clavis root of trust.
+			Format: { <keyid> }
+
 	clearcpuid=X[,X...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index f5842372359b..afa3acaa32d9 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -23,6 +23,14 @@ enum integrity_status {
 #ifdef CONFIG_INTEGRITY
 extern void __init integrity_load_keys(void);
 
+#ifdef CONFIG_SECURITY_CLAVIS
+void late_init_clavis_setup(void);
+#else
+static inline void late_init_clavis_setup(void)
+{
+}
+#endif
+
 #else
 static inline void integrity_load_keys(void)
 {
diff --git a/security/Kconfig b/security/Kconfig
index 412e76f1575d..b9ad8e580b96 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -192,6 +192,7 @@ source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
+source "security/clavis/Kconfig"
 
 source "security/integrity/Kconfig"
 
diff --git a/security/Makefile b/security/Makefile
index 59f238490665..add35a92bd8a 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
+obj-$(CONFIG_SECURITY_CLAVIS)	+= clavis/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/clavis/Kconfig b/security/clavis/Kconfig
new file mode 100644
index 000000000000..ce65b29ef11e
--- /dev/null
+++ b/security/clavis/Kconfig
@@ -0,0 +1,9 @@
+config SECURITY_CLAVIS
+	bool "Clavis keyring"
+	depends on SECURITY
+	help
+	  Enable the clavis keyring. This keyring shall contain a single asymmetric key.
+	  This key shall be linked to a key already contained in one of the system
+	  keyrings (builtin, secondary, or platform).  The only way to add this key
+	  is during boot by passing in the asymmetric key id within the "clavis=" boot
+	  param.  This keyring is required by the Clavis LSM.
diff --git a/security/clavis/Makefile b/security/clavis/Makefile
new file mode 100644
index 000000000000..16c451f45f37
--- /dev/null
+++ b/security/clavis/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SECURITY_CLAVIS) += clavis_keyring.o
diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_keyring.c
new file mode 100644
index 000000000000..e92b8bd4ad5b
--- /dev/null
+++ b/security/clavis/clavis_keyring.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/security.h>
+#include <linux/integrity.h>
+#include <keys/asymmetric-type.h>
+#include <keys/system_keyring.h>
+
+static struct key *clavis_keyring;
+static struct asymmetric_key_id *setup_keyid;
+
+#define MAX_BIN_KID   32
+
+static struct {
+	struct asymmetric_key_id id;
+	unsigned char data[MAX_BIN_KID];
+} setup_key;
+
+static int restrict_link_for_clavis(struct key *dest_keyring, const struct key_type *type,
+				    const union key_payload *payload, struct key *restrict_key)
+{
+	static bool first_pass = true;
+
+	/*
+	 * Allow a single asymmetric key into this keyring. This key is used as the
+	 * root of trust for anything added afterwards.
+	 */
+	if (type == &key_type_asymmetric && dest_keyring == clavis_keyring && first_pass) {
+		first_pass = false;
+		return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int __init clavis_param(char *kid)
+{
+	struct asymmetric_key_id *p = &setup_key.id;
+	int error, hex_len, ascii_len = strlen(kid);
+
+	if (!kid)
+		return 1;
+
+	hex_len = ascii_len / 2;
+
+	if (hex_len > sizeof(setup_key.data))
+		return 1;
+
+	p->len = hex_len;
+	error = hex2bin(p->data, kid, p->len);
+
+	if (error < 0) {
+		pr_err("Unparsable clavis key id\n");
+	} else {
+		setup_keyid = p;
+		pr_info("clavis key id: %s\n", kid);
+	}
+
+	return 1;
+}
+__setup("clavis=", clavis_param);
+
+static int __init clavis_keyring_init(void)
+{
+	struct key_restriction *restriction;
+
+	restriction = kzalloc(sizeof(*restriction), GFP_KERNEL);
+	if (!restriction)
+		panic("Can't allocate clavis keyring restriction\n");
+	restriction->check = restrict_link_for_clavis;
+	clavis_keyring =
+		keyring_alloc(".clavis", GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
+			      KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH | KEY_POS_WRITE |
+			      KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH | KEY_USR_WRITE,
+			      KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP,
+			      restriction, NULL);
+
+	if (IS_ERR(clavis_keyring))
+		panic("Can't allocate clavis keyring\n");
+
+	return 0;
+}
+
+void __init late_init_clavis_setup(void)
+{
+	if (!setup_keyid)
+		return;
+
+	clavis_keyring_init();
+	system_key_link(clavis_keyring, setup_keyid);
+}
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 068ac6c2ae1e..87a8bfc0662f 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -36,6 +36,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
  */
 void __init integrity_load_keys(void)
 {
+	late_init_clavis_setup();
+
 	ima_load_x509();
 
 	if (!IS_ENABLED(CONFIG_IMA_LOAD_X509))
-- 
2.43.0


