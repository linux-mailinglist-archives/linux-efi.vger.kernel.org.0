Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BA839FDD5
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 19:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhFHRi2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 13:38:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54220 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbhFHRi0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Jun 2021 13:38:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 158HTLVa154248;
        Tue, 8 Jun 2021 17:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=XsgewqLSNE0vAWYr95l1Pof2TG3BUOz+NJ51YA4pnNk=;
 b=RFPtWNZev5OcnRce4po7lxA23Sks36edVSwlpixCIF3h56GJLKS4spsO9qKWg5E18Du1
 Vc2PRNFq4RiUmGlMZyAX/AReAy79C7zyxcmUBo0Gp4+uF2TGr7ipE3K5T35V5boS1RbO
 IBRiwEeZh9eYEQK4uCX/Loi7FeFVB2Dwd8GTAbVEbmiZqfcfYuS+80AWjjAHO+rw5++a
 9l3cX2iu+5SV6QKNIxchS+Td2kMwwLgu9f7tMzhBj8y5qT5+eVIvKKZG+uQUN9vsYNvE
 StQZ4nSxoBEzkH4gdKiLzxaCxNvoDPZC7/w2RIuuj0WgGpgh4ZHqWEztC7HBpzktyrmE gQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38yxscew7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 17:35:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 158HZ2WD079738;
        Tue, 8 Jun 2021 17:35:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3020.oracle.com with ESMTP id 390k1r6954-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 17:35:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjI8dLVL2kBfO+D4QmxWC5DO5xU+zIfh1faTLU2RQDhiX9Rqvn8ESB6i6URWmanZOFgnljKFGUJ6WsUyUtHIZTXw5CqznJxryoSCj41fGOLqqvIVcf4GFbW0FaXQ91aQJh0kbpU7n70eYbdFhuB1LKTa9jFRd9/Cx94814atUKW8FPOpX1lmqSS82oSKhK+3LOscuHSbljgRtDoTN2/ULRwaAQibvtCBlm+WLcqj7pWSQa/rGyc5zMXpjxQ0pn1cui2qFBywcX35EtvYbAHUnamhFwgj/DHwxc0o4IzJajaN7Dwc4tG/2/8OrNSkoHQ7Pgwgii9wsGZQTuP27Aa2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsgewqLSNE0vAWYr95l1Pof2TG3BUOz+NJ51YA4pnNk=;
 b=UoeyVzz5eVj7DsPqBjpYSBgQI4hdLcejHXQ6/kdv42UkS2SBmYWEMQq1e6DnxEOT4pfKDS7E/xZdufor6XI5WkJFRz7oi8DIXXlv9Y/vdFXPUb/OcZVwgo2pbduafcT3hN+DGsdNjBbdiMUiJcJGjFH+U/vaLckjYvmjPBTyxoQXdScy1jRmSzJSKAAebj8QkAOJhsaQjNdOv56kQ5ayqlcTVwdVPGOlt2cy2z1u1DuXsXyRXcQ50hsPcK+7vMWH4ACnddvMKQbiV+aliR2rsV6GQfTqLpby/wNO42rR1u+iE0AJNla1nF26ULLmk+T0bL4CHvd8lkJReD8DZRAe8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsgewqLSNE0vAWYr95l1Pof2TG3BUOz+NJ51YA4pnNk=;
 b=BH821EzFnErya1uuvj/PVEG7sJdUsmIP6LtURXBdAosYQxl54PQwtTQ7SqjpJUnsy7bzocuwKISZ10qVymcEOyeNAYGgVmWvr/02eA3N7cKSBLqz/V1N/bFFGzGh7Q27isZ7fH8fTVSYC//D1W7m7r4BtUSfnVjvOIKHdEez+Q8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4796.namprd10.prod.outlook.com (2603:10b6:806:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 8 Jun
 2021 17:35:06 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::945d:d394:f2ad:2c97]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::945d:d394:f2ad:2c97%7]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 17:35:06 +0000
Date:   Tue, 8 Jun 2021 12:35:00 -0500
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 03/22] x86/sev: Save the negotiated GHCB
 version
Message-ID: <YL+qRMsIPLHbbNii@dt>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-4-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-4-brijesh.singh@amd.com>
X-Originating-IP: [138.3.201.62]
X-ClientProxiedBy: SN7PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:806:f2::31) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dt (138.3.201.62) by SN7PR04CA0026.namprd04.prod.outlook.com (2603:10b6:806:f2::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 8 Jun 2021 17:35:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31aaf0af-abd8-4ad2-2f0d-08d92aa3c176
X-MS-TrafficTypeDiagnostic: SA2PR10MB4796:
X-Microsoft-Antispam-PRVS: <SA2PR10MB479601CA830956092D1A854EE6379@SA2PR10MB4796.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jeR14SsTFK8PvF2D/kt8vkzo2Gcno4gyT5iNjJ3VyVPnXqIxlOgQmucyX4PKlDRkybQ9N0GNTKA9EB9iDHQTeGirNxyO/5A/psk+hzwsOYa1brA6fAJfZ59KoknDvFcFHaFcyk4uBiKPXREmHsSEIY2wejq9z+WQFRieT4Yy1XYgpqQxGj5PD0tQRyTfKfpYVRz1wuB+3IUjgZBAw0qCfnsdzSyGo+kEFKsPGqsd8M7MEz+X0Q8eVxiS57tP883/4nA2IAqFJjXaJpJOsUp4lugbxQLK2sF8KBeqW7cb+VndqHhocqk/3LwMPBLVEScmNr/x4RGMLmRIk+2JipiEjfJhGxEsYAvKSPLCQG5a8vw9LdAiVPgAEJXN1/OoN2mpTkMLWT9qW0tVfHyII28u46utwUWO3UMPBNqXd8EB6Iz5HZKCuMH3gmWGMf5ToSpWqjN4AkZE0CsSBak7Zee+e3H680UpIMSp+xl4mhYDIEWHr3SeSun0Uzw/qNADArUN3euXXYEPfJK6MrdxoZVKpRgSaen9poNxoLNRBd9XnBVzi7LeXOBJ47VmasM012b90UC8cmx+5M3+HJaoDGzk9zHTvnJKMX56lwzy38qu4QJEUv2fFfbbqOdhb8lKvZpdO6JkAaGlHkVqmc6tMfg6RzKGItUJ35QoqPu86lBPEeUFaWs3Lwz3OxeIVd/09IWC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(39860400002)(346002)(396003)(7416002)(33716001)(26005)(4326008)(956004)(8936002)(8676002)(44832011)(55016002)(83380400001)(9686003)(66946007)(9576002)(66476007)(66556008)(186003)(5660300002)(2906002)(86362001)(52116002)(6496006)(6916009)(478600001)(53546011)(316002)(54906003)(16526019)(38350700002)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PBqHMJz9qiHr9apsB7Y8rfm1z+6HkgGrl1dZvW4zbkLmAQi+GLpSlh8+B5zT?=
 =?us-ascii?Q?g94br/phMEYQ2wyOeYjFy4xyuZxBPC459gqRVAgu1Sr4l8MM7bA8/FKoBzxC?=
 =?us-ascii?Q?D5qXhYvQQTPPR95Rh3Yh8LtnrP7+lQJnuLlS3jgfdHrnPe4uwesBkDpDyBdX?=
 =?us-ascii?Q?s5x6IakwWj530XuJzAOVUt6BDbzsiMNP4vzwoGlHjUgz6j/igLhwqxh8Gg13?=
 =?us-ascii?Q?agPXHcxhC4wfFvXqjrbinmT2foMi7v9klQksfXUCctbKMb8Bu+0RWMwuH9Tv?=
 =?us-ascii?Q?1M3ZVu877aQoz7yHaBeo5bf3SzHxP2+Ifqb8Ca/M1O/pPLATiBL+NuD3/0qN?=
 =?us-ascii?Q?jp6xzjWdI/LPXbJLfaC865Sjkclgnpdh1jyEF2YhBylZnFiQBdeMZLRQMC5a?=
 =?us-ascii?Q?h5ufhJ6vKNBhNb6x1pwqEI8o7R5SsdnFazdLVgCn0t01LsaUQ3wrZo7qTms8?=
 =?us-ascii?Q?ThCy6pAmtG8jqZ4O7EaUY28O3NFoLekXYkINLpK5CI/56bqDICeAuFI+VK5b?=
 =?us-ascii?Q?G8H15VdSWEK83kReTzXUAjuEW6LOwA4m5FpzfW6kMVbc14cjnZY1wdznXtti?=
 =?us-ascii?Q?36X4g6jkLWxzHLvZLAgi0Ir6ZRDWWuO7mQp7rinozRvsTJkVyEpWop2AJ/yM?=
 =?us-ascii?Q?BSIzvBmIcT4EL3ZT8OFQcEQwHNG9F9cCMOlcDCUpt8KQq8lcJaLiYw+fl7UO?=
 =?us-ascii?Q?xFzk+MixJJW/SaPijT3fRkw3+6SQJwf2a1meIBgleRXN3CbA7hZFzRtwgbQt?=
 =?us-ascii?Q?UgoIfSWgs2frKJJUnvkS6e0keqcQwc9LEZwF8joCIPWyomz8Va/P0aitZ8X/?=
 =?us-ascii?Q?8gpxCsIXhYg9BPZOVf3X3fcjYhEKnDV5Ra1oOf5327ldQvIabu8VaGIS9MgB?=
 =?us-ascii?Q?KptnA18jr1v+LdIh0FKew03OIKT5pzIFC51JTN5/y60LCZfFPkM2R86g4u9y?=
 =?us-ascii?Q?wVkUlyWavDGIw+RYAy/0yYNhvXIH2KbP3Lxkad/V0dtdSU3vwLa3Pj2Yei+c?=
 =?us-ascii?Q?eKYxEZKrW/imbmfqEImX7uclMKxyKib+AK6UZBxSccZZDKNo49nnREjlCng2?=
 =?us-ascii?Q?9bwsN2wN7gRky3tmow/EQ1HIKuM11hYfy6O3FDV11BNf90eZdB60kHRrYkPr?=
 =?us-ascii?Q?Aq61FL+DFF0Ce6QwemDFANPlhGP1SWypLFwTK893cE888nN1vCee6J5JdC5D?=
 =?us-ascii?Q?ev+lyfTHkTEk82i9oq1HmT8ieoU7Q+iyh9Ua5f5EglU3v3Tl7L34gNHskSxH?=
 =?us-ascii?Q?qQeS+LReJncvA12ZuXa0G688Ef8k4aLWcoM5qEkF9k3WyrBJFVmqOYO5IKqM?=
 =?us-ascii?Q?uoXyUDJDe1E25f2N+PRN7n/q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31aaf0af-abd8-4ad2-2f0d-08d92aa3c176
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 17:35:06.5078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbTt9Jn5W2wbu2V8x69iEzIFZwLUmw64af0DDi9zES9AQI0m3DZu4DIc2tifLFZfjFW7rGs8oA/5HSQWYi/L9VeRX0i/aC+Xehdu9wjdHaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4796
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106080113
X-Proofpoint-ORIG-GUID: VS3K0FZgglAyRJR7hdCVQ_EEy_OpFjwc
X-Proofpoint-GUID: VS3K0FZgglAyRJR7hdCVQ_EEy_OpFjwc
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106080112
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-06-02 09:03:57 -0500, Brijesh Singh wrote:
> The SEV-ES guest calls the sev_es_negotiate_protocol() to negotiate the
> GHCB protocol version before establishing the GHCB. Cache the negotiated
> GHCB version so that it can be used later.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> ---
>  arch/x86/include/asm/sev.h   |  2 +-
>  arch/x86/kernel/sev-shared.c | 15 ++++++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index fa5cd05d3b5b..7ec91b1359df 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -12,7 +12,7 @@
>  #include <asm/insn.h>
>  #include <asm/sev-common.h>
>  
> -#define GHCB_PROTO_OUR		0x0001UL
> +#define GHCB_PROTOCOL_MIN	1ULL
>  #define GHCB_PROTOCOL_MAX	1ULL
>  #define GHCB_DEFAULT_USAGE	0ULL
>  
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index de0e7e6c52b8..70f181f20d92 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -14,6 +14,13 @@
>  #define has_cpuflag(f)	boot_cpu_has(f)
>  #endif
>  
> +/*
> + * Since feature negotiation related variables are set early in the boot
> + * process they must reside in the .data section so as not to be zeroed
> + * out when the .bss section is later cleared.
> + */
> +static u16 ghcb_version __section(".data");
> +
>  static bool __init sev_es_check_cpu_features(void)
>  {
>  	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
> @@ -54,10 +61,12 @@ static bool sev_es_negotiate_protocol(void)
>  	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
>  		return false;
>  
> -	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTO_OUR ||
> -	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTO_OUR)
> +	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
> +	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
>  		return false;
>  
> +	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
> +
>  	return true;
>  }
>  
> @@ -101,7 +110,7 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
>  	enum es_result ret;
>  
>  	/* Fill in protocol and format specifiers */
> -	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
> +	ghcb->protocol_version = ghcb_version;
>  	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
>  
>  	ghcb_set_sw_exit_code(ghcb, exit_code);
> -- 
> 2.17.1
> 
