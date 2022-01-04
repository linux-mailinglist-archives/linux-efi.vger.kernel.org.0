Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D759484AF8
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jan 2022 00:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiADXBZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Jan 2022 18:01:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14360 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235054AbiADXBZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Jan 2022 18:01:25 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204JXiB4030335;
        Tue, 4 Jan 2022 22:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ipJLxc0rKK5NeHNsqEY7ma0lKX17F0H7zX+QAXaoYV8=;
 b=rn6qtwdFqpgh+ZiU+RYUY1WfezaF4ClFGIj9Uldf9eEQPa15h5vEgRVkPXg79mL9kqiT
 xs7WqKDsH3wMszYJFdQUX0ahsImFseC45OaRI1RoLgkDyjWXKk2jU2T4e2jFp09d1vFA
 0y+olLmoPn2YWMxRhcu09VosQgkK8FfOhj8EoERaWAd3U0Fbe4eKRUFGum9jlx1OsGgP
 ugXuWtu+el57V+2jvigR6j7ucV8eKuI0qx6DyhkEPWwHBSDbgLlhbXfUVtIjs/lmNGPn
 LEpa6Nsz2SjSczCncLeO20Fr4ibf42f7t2+Epzkf9zXH8m7XfTtsGK/VF+uwOmq4ZCL0 /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc40fkerc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 22:59:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 204MtNhe159104;
        Tue, 4 Jan 2022 22:59:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3020.oracle.com with ESMTP id 3dagdpawum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 22:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtxyXMJKbVbxWkeNMOhzjbPp6/YKBKe4T08K0WaLbI7OLHpel0lg4UHXZs/5aLysABtzDu1icNWVtBtQqKeHixdXrPmNlHN8L/s5QVn6Bxmw0E6U7Ny7pyTEkSWaC5FtZf1gXAj8NdLal8fLHK8CBO+ylQzibrFubVWrEmkHSyRMv7cc3MLL6z+mdHMTx8fsd1UI25sUAqGM2eZXWrE33I1m+OcoA11A0IOxhabNDuZutCCjpt1TwMttgVS0NS3pCWhRalh0XzjDLAvcXFcY000bzRCtDT61zOi0PpxQnfaTaZJRPa/XzpjJ3fmp03QWH4/4Pmvjbbp15ezff6XrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipJLxc0rKK5NeHNsqEY7ma0lKX17F0H7zX+QAXaoYV8=;
 b=Wv2JSW+Mid5gw+4CrzuQGeMF4+Mhix8gKm7lQjmULGT98ICxadS9Othj80mWkooLfkZ/P65ikOpqNproDq/QbocLgO5O6idKuI93BPVZ0puoYhKe60ednpvw4sVJqkuJXUFN012WJ2DrgkGZvoIjj17h9Tl3uOX2bdmq+xu9Do+0+Ca+O0nNWgO+dzMYt98PXTuENbk3aJv767chA5wN+RaAYOjcyrgdAwZ/i5TrroVRI57Be6vBaMfqM08gF/aE1lSXYJjpC9TdLiPsxkYHi0TJXu0h+OdyMRT2YJXFuBzhpK6wOGR6ZTyifobNd7meo3QN4c4Fvb2dOxqhpJsmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipJLxc0rKK5NeHNsqEY7ma0lKX17F0H7zX+QAXaoYV8=;
 b=ZTkAzNJC19O7BYOqBUlp57mOg45TH2VTEpTV9oI30zbmE3q1H+4sAIi/6dv26IMMgJOowluwgf8hHRs4CB47+a0s8TiLpv10e0bpHw/6jwjTigBMSgl19Fcb/ICn520nUWceR1vbiIkAs6UPwSD7Us5gTs6LQPsAdj/RTQSCpgg=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4683.namprd10.prod.outlook.com (2603:10b6:806:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Tue, 4 Jan
 2022 22:59:45 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 22:59:45 +0000
Date:   Tue, 4 Jan 2022 16:59:39 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 16/40] KVM: SVM: Define sev_features and vmpl field in
 the VMSA
Message-ID: <YdTRW6MeJtUmd8zi@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-17-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-17-brijesh.singh@amd.com>
X-ClientProxiedBy: SJ0PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:a03:333::21) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a72d002e-9789-4513-ab22-08d9cfd5e66e
X-MS-TrafficTypeDiagnostic: SA2PR10MB4683:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB46832E46BA61278BF807D0B5E64A9@SA2PR10MB4683.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3eam/lVvwOlWL8TR2eCRKQRLz49+Yaa4EMRPUDzVsXz+zXotdsn192KGPIvFXYYppRRDTFt/ucuSj4b2a3fKFxnfMs8VXUzdrV/NPe+Vp3x+AQEe9ztBgw609kN2109trY5nIwcl+ScQAb+HvCQbJQEhSRnDOODawhbYlo4VhsZtxW+7Vosvqy9Hh2j6BO7+rJv4PuM2G2qfqBjy8sKtJAgOJF0Vn5nP52gOmDkslnXR+gnwMhSTxtldbEwt6XyJkE2FuWo2q+YtWt3/KUjf+6XNjv8cwxH4le6tj5PAw8TZQiDSnsEjbKc6t/L/Nf+4zihl2g4LbKA2eYuW9t/eM41GSuPcQW4lmForkXgCTXJ5LSBuwawI9F/D9QKImw4FEzexk3bLRBnHNF81pxW4rqI3c4lEIhC7z7GMEsSp0E8vvgqqPaVmCTMGeBJiEFj2/Xn1erirrr4GMd20oUZ1r1iMc3h/oBT3vOpfyzimmMpa5wrjHhJ/q++VnPXybcjlFwqIEJJWftiB6xnEey9vuQxK0n1wQiRBC0vxq3XxB2voZ1enH1ndY4aN/cEelmYyEaR+e2SKa8be3AvfAhvm2vdPjKEDw/CxboStLhMWbrH4oV+6wLRXCYH++fQIUYqMQhp1TalZ/3L9/Uf/uUKMkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(186003)(44832011)(6506007)(53546011)(26005)(2906002)(6916009)(83380400001)(5660300002)(66556008)(86362001)(6512007)(38100700002)(6486002)(508600001)(6666004)(316002)(8936002)(66476007)(33716001)(4326008)(66946007)(4001150100001)(54906003)(8676002)(9686003)(7416002)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NT7rYfFWWU+VDNLMZFbymviDBxWDQmfOhNo2oAm79xMQH/iXFNmVqjwNI4vi?=
 =?us-ascii?Q?aVP2IKKTSgXv32UZkvCeazmjkUsk2lDnptgp8wAIpF89asbDhkMq3fqyy2hE?=
 =?us-ascii?Q?OCz9EwenX4IxNLHrl0OUG1w19T42T3ganhLcTV1KkgqtsiUmB8whpXs1xls7?=
 =?us-ascii?Q?wdeSkPuhqm0emOIFOMI5T9qZlQhhU6PExFVA11PZBeo+98+PSV6GNGfZQ+BT?=
 =?us-ascii?Q?Hkp/VVea6Fy1Hurh2yr/dqc+a/e/VJ3mtIKH4PqokkE55mTCHbQ5a1uXeXPR?=
 =?us-ascii?Q?xcEIkr2Jmo9BFrmP4676jWBkUrGlVddaJPzpdDMDEJ7vSnIBh6CzeNlb87Ll?=
 =?us-ascii?Q?S2ipToyEyU1m0Pdr5Smrx4F+s3FGLWr8QGe/L9ZNDnwa6SEgi0bvfl5o0zaj?=
 =?us-ascii?Q?vqeJ7cV0dGmS/MckXtwSxvoWGcuy/gZKrloXbN58ALMtJB8xgrCqTQIM6Eb6?=
 =?us-ascii?Q?SMkNnUsziTPZ5M6+e/Z7YaLIaAAXc78vZjy97GEBcJmNFXRfs5RLhTw45LdM?=
 =?us-ascii?Q?Q9kAWvrtdnAUwj8x42ePlv23rGroec1qBMDZnBVrbZVVaO9UBCt6eNn3Ia1R?=
 =?us-ascii?Q?fJMpQGOhjWTyE+jlXiCCM6oqtbW9yj88IZAVz6vP8/nChvMl62nrIhSqlpI0?=
 =?us-ascii?Q?NBXmpCHmn8iHaE4YDZ4kMlNxWVhIiDBhe/hJayu2M6f/jVzsWc1+GZ75JWhq?=
 =?us-ascii?Q?XW9Gzsdht8LH144JYBYGrTyyHpx9tTLVwbft0hrtpp/Cfa52HP3Syuy7ArbJ?=
 =?us-ascii?Q?Gdi90YSg4OQ0bH5eOj+JjQtjHKW9OWjrHd9X3GKq86nFAL27LiHZ0DDHCrT9?=
 =?us-ascii?Q?2J9V8o3ill5CuJTbzAh4kPZeeDSgyY4uTpgF86aUgBoP9HDCJiF+5rJ8Ujxg?=
 =?us-ascii?Q?ZRy/XFXBh+ftTf3ty0k/mkzoghA/Y1KzBSID9wQDwfkUApAbwGnO/P3kB8Ib?=
 =?us-ascii?Q?5IhpptLdtFnUpeP21X3SsQOu7HnrcwAN4FzHQhTjCA1fFHZin9BcczhK0Kw/?=
 =?us-ascii?Q?ZMlcuEVQ+2SNXGz9oSVOO1nzYAwHI866pA1n8k2fvSmikPu4WtBsKOOFF4Ib?=
 =?us-ascii?Q?ef4kJb28n7FwC/SnY6822a3g2DhaYngr9JVPt20vbcQPW2GtPsndqmTULrsa?=
 =?us-ascii?Q?JivKUc043FOIYfvb9wCIjYTImF9FRCzjQ6kbgNIyqxctFCyHry0mOtMVZenI?=
 =?us-ascii?Q?QLQDK0kysCzEwINXe+Y+KULHFQvk3viizVsWmj2Q+viM5xD5kOsvy8PxTzxn?=
 =?us-ascii?Q?+DIZAXfJT1i/seupHniPp2TzzFRtXS4SIXdjIETx4rtGB0lsxM7cvtGbwvwp?=
 =?us-ascii?Q?CtUGTvup20gggusYUqrPMZ9cie0OztE84u/S55o21mB8Ea4nB6cftudUexCX?=
 =?us-ascii?Q?eTR1Q4rmGDS8tjtdRDn8XLkbm5VdtlJL2r4F7H0Z2go/ycYwWStD5/rySV1I?=
 =?us-ascii?Q?+LNkuozqfXgW/J6OS5uqPFpifOLz53sMVLibemK8wApWqrkwuugDM2OcxUiP?=
 =?us-ascii?Q?rzEtvfd6GdraoYf1C0oJWh4GEimqZw4ZmaDNJJYuWazHSOlOd9A5bu2K1IyJ?=
 =?us-ascii?Q?raNfbzERb2a2Z/ElSu1BMzPRrd8Dys46OCnaon7qRp11rWPFWN3d3m/sAvh1?=
 =?us-ascii?Q?r2OU3yo6LZsxBYErtf3o5IW3ZLc+XspYKH5NHP9wOCnv1D76IXgu4jskzRbA?=
 =?us-ascii?Q?TjOMOA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72d002e-9789-4513-ab22-08d9cfd5e66e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 22:59:45.2291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oxoYGom4dhPu9RHdnujC0pm2YtDv/fzLUBLVf9GX5cuJE2Kh7VJHTT27/fUCnqVdBpmZZri+EFRoaJk8W2JUKHvkMs7+VmNRixOjmPefJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4683
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040147
X-Proofpoint-ORIG-GUID: TXIzLZ4PtEcBqguPn2Q5L5mfgyWG-jKb
X-Proofpoint-GUID: TXIzLZ4PtEcBqguPn2Q5L5mfgyWG-jKb
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:08 -0600, Brijesh Singh wrote:
> The hypervisor uses the sev_features field (offset 3B0h) in the Save State
> Area to control the SEV-SNP guest features such as SNPActive, vTOM,
> ReflectVC etc. An SEV-SNP guest can read the SEV_FEATURES fields through
> the SEV_STATUS MSR.
> 
> While at it, update the dump_vmcb() to log the VMPL level.
> 
> See APM2 Table 15-34 and B-4 for more details.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> ---
>  arch/x86/include/asm/svm.h | 6 ++++--
>  arch/x86/kvm/svm/svm.c     | 4 ++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index d3277486a6c0..c3fad5172584 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -238,7 +238,8 @@ struct vmcb_save_area {
>  	struct vmcb_seg ldtr;
>  	struct vmcb_seg idtr;
>  	struct vmcb_seg tr;
> -	u8 reserved_1[43];
> +	u8 reserved_1[42];
> +	u8 vmpl;
>  	u8 cpl;
>  	u8 reserved_2[4];
>  	u64 efer;
> @@ -303,7 +304,8 @@ struct vmcb_save_area {
>  	u64 sw_exit_info_1;
>  	u64 sw_exit_info_2;
>  	u64 sw_scratch;
> -	u8 reserved_11[56];
> +	u64 sev_features;
> +	u8 reserved_11[48];
>  	u64 xcr0;
>  	u8 valid_bitmap[16];
>  	u64 x87_state_gpa;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 65707bee208d..d3a6356fa1af 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3290,8 +3290,8 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
>  	       "tr:",
>  	       save01->tr.selector, save01->tr.attrib,
>  	       save01->tr.limit, save01->tr.base);
> -	pr_err("cpl:            %d                efer:         %016llx\n",
> -		save->cpl, save->efer);
> +	pr_err("vmpl: %d   cpl:  %d               efer:          %016llx\n",
                                                       ^
Extra space?

> +	       save->vmpl, save->cpl, save->efer);
>  	pr_err("%-15s %016llx %-13s %016llx\n",
>  	       "cr0:", save->cr0, "cr2:", save->cr2);
>  	pr_err("%-15s %016llx %-13s %016llx\n",
> -- 
> 2.25.1
> 
