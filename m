Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0574B502E
	for <lists+linux-efi@lfdr.de>; Mon, 14 Feb 2022 13:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353177AbiBNMcy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Feb 2022 07:32:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiBNMcw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Feb 2022 07:32:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824264A3C5;
        Mon, 14 Feb 2022 04:32:45 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EAYjrM016370;
        Mon, 14 Feb 2022 12:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=FDUZnxukbXv8UO8SMlmZ3ut7znUVxr+9wGQzvbexldg=;
 b=s1jzAaER/i3BfgduZZrx4SnDLaWfphhkWxxAj/DRNRAuXz2Hhs+dmlJaqyTSBRaFQbnq
 xizHTs5d7ctaZxfg0LmERd/kQLFkSXFo/VXK/950U/FvQQndxdWk0G3ljbeC3lfEJLBz
 MZdl2KAVdw6Yh53EhfGBk7b1T4fI4JqzMXaf0PXUqW5Y6hkIF2TFgzYsowPx6R/9j0GD
 9EJAW4bGeq3c+5VDCXpx2hJLdY56NLo/XTAgdaN9fww5/GMWPrdmwD/5eF1s0MVxx9pf
 lYAwKVzth9ewGpgUfypGLktvAGicCaRf8ngNDiBGd4xI4gZTOxrZrJagFySvDu0777ZO 0Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e64gt4bau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:31:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ECUfSR134926;
        Mon, 14 Feb 2022 12:31:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3030.oracle.com with ESMTP id 3e620vvxk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:31:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPSoS6uqmNmFV1Aj6XhIvPMtNmzWFxtdg7sLlB031ellV/hF4Wx9uVwKLRq/RQqAHCF9+KFTDfX3O6CSI/8ux4ashqPeB2E+BfY4gQRX0YqDPoSM/1HDj4AKD3nRTcON9ONX1AIFSf+Mrl8X4ihtYKVUSMXaoGaN0YQx7wSHuzdLen2ntoDTx8F5vaeGhFrXsHqduzeMyieDlwhhzqFlJv1gCicukI98m96N1S/H5bvjlvUNJG+TsKSXAIaNbXVuSOYjGSvcb4ITTyusu08mzcKkoU0PNvyWIm6HTO32uRCGcoVJVrZ2PTbstvhegbSW4VjOJhAgIEqUUGH0B3KBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDUZnxukbXv8UO8SMlmZ3ut7znUVxr+9wGQzvbexldg=;
 b=XpijWGhFxxkFdPMLo+xbx7daVQpUjQ+mVOdyqdmry4e1NTIoASx1XaYKf4yJgoCjJ0eMuo35uaZm7rhq1s8LQ9YDd5ZYnR8gcbNYzWzFbX1FrV/zQsjBd4EhbCN/w6lQVmGgl4QNrW9o291Y6z04ahuEbzz/TnedVhKHXwiY7WO4RNNC5wu0YaD8pxzslP88SO0uZBuCPWjABuhZeAvlL9hDz+7EViUuttb7tsX0mL20wZ/DNlcfhSfZhROSMvw2XD9+UiVXxNOofEte9ZZeL+VK1sU5WibdjAOsD7PniA5z4/j9X1HDQmE2DuOX9L4bns6Bctsjfw4NXjIuKNyx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDUZnxukbXv8UO8SMlmZ3ut7znUVxr+9wGQzvbexldg=;
 b=pNL0AVh733s901YUxUOVNO3oKXwEQf1vzFdJd74sTmU+5czQ8/AyCeujx1EqkEdZHwLv9lhyfWC9AgFAZeq+acATdDWOftj4bRqD0fmZ8vQUreL6vUa15vDxWVLmBUNlUTwATkv14X6KUhVK6/uZn7zHx+CwOAimRk+UPLhZJgE=
Received: from BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8)
 by DM8PR10MB5397.namprd10.prod.outlook.com (2603:10b6:8:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Mon, 14 Feb
 2022 12:31:10 +0000
Received: from BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30]) by BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30%5]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:31:10 +0000
From:   Darren Kenny <darren.kenny@oracle.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com
Cc:     eric.snowberg@oracle.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com, jason@zx2c4.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v8 16/17] integrity: Trust MOK keys if MokListTrustedRT
 found
In-Reply-To: <20211124044124.998170-17-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-17-eric.snowberg@oracle.com>
Date:   Mon, 14 Feb 2022 12:31:05 +0000
Message-ID: <m2a6ettyt2.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DB8PR04CA0012.eurprd04.prod.outlook.com
 (2603:10a6:10:110::22) To BLAPR10MB5138.namprd10.prod.outlook.com
 (2603:10b6:208:322::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe46aeaf-b034-49ab-5ace-08d9efb5e184
X-MS-TrafficTypeDiagnostic: DM8PR10MB5397:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB5397FC1D315BF8385F513669F4339@DM8PR10MB5397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xi4ecc1Xt6i+zRPil++Fxu0tpKMV+TbBjqV1sROOaxBCKnOlPAiCnxhU3lFq216hnlg7YJGH5jkiXN30fHQ3Y8NcV2I3E07SnD8lcckg50Y3Vp8BbpSOudBjAxeWbNUZUzu/vdecKKS1gXHkmK8P625+/xY/vtF/aZnnO1/e4Fjy7uUaSxLhXbNni49K8vgIDd0x4sISanQTuupGcBuPTmi5rKsgCLosRHHcPBKDhQ7NFEL0XsKA/hcfKV4C9wht9PKFT8S/+FPS7+3R9nxjucsh4UjswPgKMCegZD1az+JNppEpZqcXS91Q9NHoyovZ0dsgofyvratzZFdZW6yY8BW8Gc+Hxe3oqzAfEIqIU94WE+TduuHz8V41NOd1RJ6Eo0yn58giiNAQLstDIm5DgQ0NmvfHW3ixHRHNUHUL6+hSTW/atQEGRzFq7WrvyF4JGJrJ+sBZS2O/PTwizjHh6WNqn4/8CWAD4BxiiOPhWfHhfrUrKi9wZVunvRfGSI+QrjroszlY2vLsJdK0rws+H0tKKuYx59zNbILuuXVQuATNigpQpYkiJ8ex4No8Q73uzF/RoY6KvPYGB0lK3LdAmhrFHG6rpq8VIBGH+h38hc9TUp4fTvoTL1M1jOTXK4KsjYEixFNUHaUQ5gPx6zHR480Vle0l2sn+l3+5AyFccZ3zJY33lvRxGbAQr7j6aQPwA/0/mn3BTrGYbKIXRjRFNfgWfH2S+UGYwlLrq0nZDT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5138.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(38350700002)(83380400001)(86362001)(8676002)(66946007)(921005)(38100700002)(36756003)(66476007)(6486002)(316002)(508600001)(66556008)(8936002)(26005)(44832011)(4001150100001)(186003)(7416002)(6506007)(5660300002)(2906002)(107886003)(6512007)(6666004)(52116002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RkAvhGgvhKV91gQMy0wtd50xzcoCs8mbz0cFd/NYg/F4V3qb7selq65RDxHP?=
 =?us-ascii?Q?q/xWuryFqXleqqLBJKsM0+l+pkfL1447j2eIhmSQzdAjYavUUw7ya0ec5tDy?=
 =?us-ascii?Q?h5JOXHW+Ve2ADxtHalUGLff1+xAAr4Le4AjgF/PlSlKgnWSO0VsRwxygGtxk?=
 =?us-ascii?Q?y8s1Pp0kPhpZeJTcecZTi2x4/Cj9GilYN71N/mWgF2U2fsFR6h24TKdSzjDl?=
 =?us-ascii?Q?iWNourOpBfX/++wmgIFs8i+3PCnWOCEXndoZcOixobpYWwNgfnjMvvk17+xX?=
 =?us-ascii?Q?tTsvgPYCeH6XDl+OndwRQXoAAxKf8Iwk4xlmE4Lidw6w5yuDK8/+8XRjtPup?=
 =?us-ascii?Q?vFed6QxderzUzjK8u4HJvQgAkSh9QiI8iDBWNNNGvndUkqe4JWztFwG+VM61?=
 =?us-ascii?Q?snVyttuxjIpO/XszlBp2wq4mOaAwBiEe1foJdm22ktYlJq6/gBqln9KZZZRL?=
 =?us-ascii?Q?OpB3dvRieykjjxv5BD7qfSbLs5/xpDAMvjpZB9imIP/wAN+wqn/mkVDfDQvx?=
 =?us-ascii?Q?jOU83ElxPY6ET9GYSR+IGePYuaPZVQLUBTm0M5I5pgaC8W2StR+nVne3c78H?=
 =?us-ascii?Q?3zrJV4LCU6+B5bQjehoiiSNB6UKr/D9WVluZDUQV2nFlzWyWT6nRQs0fBSxR?=
 =?us-ascii?Q?d96W50OnJbzPI3tJEHYZ3Z1XU9NSKvHT3dh5dA+Pcaoear0mu2UZlAo+2x9z?=
 =?us-ascii?Q?c6tLqvM150U34FXuP+vweFsGPVPcd7cWTPVMzW1KfWhaHCztzQrk0na8h0VJ?=
 =?us-ascii?Q?SKG1rr2phaUb5Wqzx0dYP5dN5S8FlQoR3Wxv8PxdUcSkMPFBPDmhNVcfGYCm?=
 =?us-ascii?Q?9h06/GYyNxHs5WRtOcWmKvO4bRmAP6Kaye0Z7GshR2BLeEdivDqocYEHTXKo?=
 =?us-ascii?Q?5C+sQpocIiLMtbCQJN/KWrTLoX7qw+YjQBq6KIMcVABKkItH0aPpiTeIXvDW?=
 =?us-ascii?Q?BAJrOiPWZSrVyA4f+n6Wi8IRnYyTALkwrIxch/4m+iYAsIcFgky10rQ4DjjN?=
 =?us-ascii?Q?/zIJPWiZ3KXVNkpZDCNPozWQGwfcV3Lkp0dWrQ4Xc1fdCnf8bXVmLBEMuYm9?=
 =?us-ascii?Q?bhdMuv1GsdBhDse74TatqNtEKkghomJotxuFsrltOa6cwv+O6HeSG/ecGkzy?=
 =?us-ascii?Q?KE4eRkPBqxd0pdVdeUXTErKnLGkKY7b0ToMovnsLMJY6Y0uSfOdxHfqDve5X?=
 =?us-ascii?Q?PHb9XiDr6JuCujyA4N5zYT4D+KQ/e0Jv21ir8pgMI1Svte9IGJoxVZh+i45Z?=
 =?us-ascii?Q?DYoxZ9aKu+5cX/94VpeJsw9I7EF7ZLMs2JSDMojaPWQJJt/obBLWqtpVz4pf?=
 =?us-ascii?Q?3Zp4YYBuzZwvUqe60HbaQaP6pe/32ekbIuDPG6PBhc3WnpW91u6CMfNagWnb?=
 =?us-ascii?Q?zGQtlsswZ3qpzROHn+KfBg1ITEGjGrAY+9fFS7W/C3tz+cerfJs9ZEQ6mCLb?=
 =?us-ascii?Q?rUVTkiDMk1IVS8vcZ4W85z3LIXdRFoDTCIQ+HQ1w9Gg4q1sKIiZgrL49sN2z?=
 =?us-ascii?Q?Zvx0uIc1Eb5I0A2I41hi5BJpSyBUoWbwBPw68YvGhnQa3g7r/sNN3DXy5Dqj?=
 =?us-ascii?Q?HQ7DzXhKkvtHfZS9oTGtm8NHBab6cJ9eBRnf8ld4ruKV5t1d4E2/+RwZLhIH?=
 =?us-ascii?Q?mRSfu+jrbpxkradFxLgEA8A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe46aeaf-b034-49ab-5ace-08d9efb5e184
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5138.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:31:10.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AIc4+GOK0EwmY4Xxe55zuDwTGRN54MIcXsWMu3+NE8m9ATR07ppmhSsq8Defd2ahOOOGtOmatGq7/l1R2FJAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5397
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140076
X-Proofpoint-GUID: 2OD3VSLPcMxkbUX7Q_C_TTApwHdP89tw
X-Proofpoint-ORIG-GUID: 2OD3VSLPcMxkbUX7Q_C_TTApwHdP89tw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tuesday, 2021-11-23 at 23:41:23 -05, Eric Snowberg wrote:
> A new Machine Owner Key (MOK) variable called MokListTrustedRT has been
> introduced in shim. When this UEFI variable is set, it indicates the
> end-user has made the decision themselves that they wish to trust MOK keys
> within the Linux trust boundary.  It is not an error if this variable
> does not exist. If it does not exist, the MOK keys should not be trusted
> within the kernel.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
> v1: Initial version
> v2: Removed mok_keyring_trust_setup function
> v4: Unmodified from v2
> v5: Rename to machine keyring
> v6: Unmodified from v5
> v7: Use mokvar table instead of EFI var (suggested by Peter Jones)
> v8: Unmodified from v7
> ---
>  .../platform_certs/machine_keyring.c          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
> index ea2ac2f9f2b5..09fd8f20c756 100644
> --- a/security/integrity/platform_certs/machine_keyring.c
> +++ b/security/integrity/platform_certs/machine_keyring.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2021, Oracle and/or its affiliates.
>   */
>  
> +#include <linux/efi.h>
>  #include "../integrity.h"
>  
>  static __init int machine_keyring_init(void)
> @@ -40,3 +41,21 @@ void __init add_to_machine_keyring(const char *source, const void *data, size_t
>  	if (rc)
>  		pr_info("Error adding keys to machine keyring %s\n", source);
>  }
> +
> +/*
> + * Try to load the MokListTrustedRT MOK variable to see if we should trust
> + * the MOK keys within the kernel. It is not an error if this variable
> + * does not exist.  If it does not exist, MOK keys should not be trusted
> + * within the machine keyring.
> + */
> +static __init bool uefi_check_trust_mok_keys(void)
> +{
> +	struct efi_mokvar_table_entry *mokvar_entry;
> +
> +	mokvar_entry = efi_mokvar_entry_find("MokListTrustedRT");
> +
> +	if (mokvar_entry)
> +		return true;
> +
> +	return false;
> +}
> -- 
> 2.18.4
