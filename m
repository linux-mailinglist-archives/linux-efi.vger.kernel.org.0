Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80424868E0
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 18:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242190AbiAFRlu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jan 2022 12:41:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26558 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242185AbiAFRlt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jan 2022 12:41:49 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206HTAKc031900;
        Thu, 6 Jan 2022 17:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=FeHPs9vxJnSHBHgTMRO62IxmFc9cUTv23sonwaeND0s=;
 b=cF5Yz+ZH4d7WuM8oKMsYgqD0KyFHCFlWHX9eCm7wrIrJSQ7IqgaswCaezkejnAnRdWN2
 TP+8y067Q7HNn8vRhlobmxF5hb79SvA+iEj7FfDUi2eGfoIktOF0DfnxCaw4zAdqqKe+
 swtiDTjOmbcVOBPB0OiyqqRwq5QNoRTuv3vNMolnVFvHSQ1zeyUuupBOVbc2xP+XB3Bq
 sOcEobIVeX69Hdxk6sTKpB37DMqb3KfH70dJjAZzPqig2/IdD3Ly2Py+EV0Y8oZGxex7
 x5K/xSWeXk4mZLD07E4P1avKkNzMoRK2VSVpQvqHzceviU5c+ahTAPoDWrFLa7li4Z+P TA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v900u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 17:41:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206HTuHB167692;
        Thu, 6 Jan 2022 17:40:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3de4vm0jpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 17:40:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJ2011WvJGLzCxupM1HkJjFSpOXb6SlJ9ZC5fv3BKQz3FhLRNsiDvCgK7oT/5wxzJ16Rhs59yiFZx3jk9LhjI4UjHUsYee86QxfPBfefhOQ3HaY+RWQ4ML8tzJn8NqCbuBT4Kfs8u86d/z2DeGQozoj9n34tjM3cfIBe4TSq65ekr/lbFlYzgt4bNxP77uIj7K17MFTYV4JWwPgyeC4CpoH03CzBsy6LvRV35JiGPwrqsbjfkar1ACeukf3WU+VCHyU0rhAntFDYZOSZD5TbbTxlF78dXsaZ5fHREDV5mJkZl6aTm9TyFORTY0ocnbjJbFKj5ss5AJsmwLeJATuo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eM6XIlanlvxofYiOHbReb8U3MYx08I1J8nFOZCWgKJw=;
 b=aRpTY8+vqqnJRtHzB0qbVRIDKu2JjovwyIRURLw8mLb8l03pwWkYXc3W3SiirDN+2OlR1Nc1wRpnB3D0UIdzE0BNzhBb6YI0i9Wm2Zk3FUwQ2r2g4YcA/68jcAf/jdfy91S77jbXQfvS0KOo63MGEFbsDpf62xINy71iszYwnkHWWmy6M1vfadyGBAbEyC2r4L1xDjTcMZd4gN2Vegda+JrPnFUzs11kg+QRZ9jpHZ6EY9fpGPmTOOz8Fp/tFTjK1hv+H74LqngmTNWV0s0mt+YXYm4tL9Ajq90icw+Z0lIy5OIYqI966eaZrYl5rfoE5IlyS6fXYWb5aQXk1k0RiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM6XIlanlvxofYiOHbReb8U3MYx08I1J8nFOZCWgKJw=;
 b=lp4hFLs5bHn6d3lGbZn1d8RwWk9Hk7jBbpP7C1zyVm3eM3TMoHEqWd/9d/He3UWFcqWPji/OCyyVIRKHPhOdQ9Ft/K92HnsEA/R6xTHNwsqypGUb7ob6pQESxD9IhWiR9OMKAT1W3CyQgcj71p+ywODnJIJXu5z5ekd9ZQvQJx0=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2511.namprd10.prod.outlook.com (2603:10b6:805:41::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 17:40:56 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 17:40:56 +0000
Date:   Thu, 6 Jan 2022 11:40:44 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
Subject: Re: [PATCH v8 13/40] x86/kernel: Make the bss.decrypted section
 shared in RMP table
Message-ID: <YdcpnHrRoJJFWWel@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-14-brijesh.singh@amd.com>
 <YdSKQKSTS83cRzGZ@dt>
 <18eadf9d-8e31-0945-ccf4-2cb72b8e0dd4@amd.com>
 <acba0832-9b11-c93d-7903-fff33f740605@intel.com>
 <444b6c78-c4d3-f49c-6579-bd28ae32ca3c@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <444b6c78-c4d3-f49c-6579-bd28ae32ca3c@amd.com>
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55dab605-a150-48f2-6ee2-08d9d13bb1aa
X-MS-TrafficTypeDiagnostic: SN6PR10MB2511:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2511D5857F87112343614823E64C9@SN6PR10MB2511.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJvDWjY27bkOhv+VDGzN+pX/AuilX9tKwHpTf0k6NnTPuUlhYbrUo4+K+1tLMJRhUFC9k7q1W0zzj6fdvN0MDlpipSq+yoLe8ngpnqzZmHu+RRg53o074Xf6YQX0hz970ThqAprqSXMxE3ultXFvwjXZzEpyxH4hukhy7HkAmbJT20rvnWMtW8Zy752ijkbsTz2dGHQ4jzYmiClkoP26HJCuPLlb245rbWQwGaefQF78tnmduKmMLMW5T0hEAIDYHSlkGlZF6tRuzR4CKKWIiRQ+0av0BtOhTQe05c3Cx0AfdG6PrS+jRLwhyZ8FBDbvVekQK/z+pDTppnM9jPoB+2DUcZCm18NPWUR5kdgcmgbbgXKXjHd8ys2fW5koL6q+LU1HvQtmUAeGqp1rc7proIVhuJolza7bA9mEwWVhAQnATdzpeXvJKNkRlVT/BKzXQyjqx5X6NoPVtyBadvd1PsmZ66gwHOmEDVdCrdgqAyn9+4uWqyKULn2LvvIrPWaNvTBq6k3oRTF20qEuR+vEdLr2AFRdAdFrdlfexRKMpluAh26xPYUsfi3Jk/CIXkvj8esQl/S72GAMlFXC6MCajz0aw08m/cFaQnq19PJpLtJn1nLxVwKu2oCf8MFY161yf8SX7nEulExt1ltdIP0Rrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6512007)(38100700002)(9686003)(8936002)(83380400001)(2906002)(6486002)(6916009)(6506007)(5660300002)(6666004)(4326008)(508600001)(316002)(66946007)(66556008)(44832011)(66476007)(86362001)(26005)(186003)(33716001)(54906003)(7416002)(53546011)(8676002)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Bhl+NK8Z5WL+gD6oHaKc3GjNGtNMmsflIKnJdM5autv3SWo8LyqxhRlHrV?=
 =?iso-8859-1?Q?CQg29W/mJOJsOVLNRcX4Vyu28K0XLytg+EBIgNEno3QOdBnoepi8RVLK+O?=
 =?iso-8859-1?Q?0jkvhklp4fr2NWH5rpAExvzoVFJu2N+a1L2Q+xr3iapxyHsz3pZi2nsACA?=
 =?iso-8859-1?Q?hRY13Q6OoJUCkVHcdqtz3UavGDGKh6LzLVKIRcEOaunTwpsW5xZNjBab5e?=
 =?iso-8859-1?Q?1rs+wPVwya8TlWNELd6pSiv7emDOtVq9oA2OM3Ht3V+0XwNxtBFPELwAFt?=
 =?iso-8859-1?Q?i6bUJF2fzHHg4+ilfKo+sF5Bn9pmICMM1Pp3O6/ZznHrWqoOBizUclt0zC?=
 =?iso-8859-1?Q?qNg9WUhY5zkKKi41owIrcDDej2KeZTBQPJYiyzEjTIjOQRJVUGVLh6loN2?=
 =?iso-8859-1?Q?9AuYTU+UvYIKOjVmXvwM+MfPtkq0nyOZU415GKqdNJIoeEGKXwTnKIznXD?=
 =?iso-8859-1?Q?l8lo6dTrblE3u1u91fA+HtsFy2MMGviaFrrtDi8stHw88xYcjtztuOhY0M?=
 =?iso-8859-1?Q?ZVpxtA597oUjSKR5pTJ7l5X3ckBopcPK4SKiofDVcsBLG0Nmv3Rsw5ztQt?=
 =?iso-8859-1?Q?JJ+UfzlYa3AilSglojA/rEnod293ShfwqvQa0R444hqm6rBAZDmZNrXj8d?=
 =?iso-8859-1?Q?opiOTuooHro0yWDDc3bNOS7DLuQW1Qgzp2861zFKUUNLmGIiuR+NON0p0E?=
 =?iso-8859-1?Q?MEw6awcC7ZXg2xWLUCNjMk8iyUdeEhX0PU9xnNukAeNL4dF1XQI1WXbSdC?=
 =?iso-8859-1?Q?1pYJ9txX4ncH6M3Yfu8vW+dBCfXHFIoZlsUJ5AbXvKz7LDmeZ0RIFem7Lo?=
 =?iso-8859-1?Q?hM1nrCV9CjKt/3xRIqIYHy/b0DFdcNiqRKOY4wfGrOAjxtxV/6UP79mRC9?=
 =?iso-8859-1?Q?HrS0rJwNk/sWwoTXYFMKpCvSErNd6OBpRZFfzTxX/Kb8thxoTDCjjZE3Ft?=
 =?iso-8859-1?Q?v5DRosmoEtf9fB9fPi6aLiFa1xcXP8+X7QvSsdiH6UG4TxlXoj4zA1EQGq?=
 =?iso-8859-1?Q?wnX6lkfX4tr9jXqIb4ebEK61lyIx/4xjCZ0h4F0d7UvGyQ64DsP5hkC5Lh?=
 =?iso-8859-1?Q?o8O6aUHtKdFshFjpDUmXss6WUDbMTKmWwsJi4yDULVpmyeoOpl0temeD1/?=
 =?iso-8859-1?Q?oC7Vii5x+OpctFdjHaIcdvNowQHktYdOU3xbxFF43aR8m9Ig6af2V9qp1E?=
 =?iso-8859-1?Q?iBl5deAbg2qC6nMA/aPsmKvt2sFOTbJYfKXFplCtaqkHTcO4BNvuNha8Vy?=
 =?iso-8859-1?Q?NXen065/N2N/yGVkDlf1Y0J89M4I5uispsrsXlc0WNKDDIfdSvnbf6lSEQ?=
 =?iso-8859-1?Q?MvVKnED9T/16z0/W4laidGB+pel533IxMUE71q+Oqp2bIn7oRHXZkCjbq1?=
 =?iso-8859-1?Q?cslTgrDKJXMlIMgFYSlfglzaNwYTQMz6uQeef1fnhlMSpNovqhS8IQIdFI?=
 =?iso-8859-1?Q?hJrqJ+rSDTHlnGKg5626xlLYbougspkf2Fdrg9vSRwV7vLTP4BvlgCB5Z5?=
 =?iso-8859-1?Q?XsGSvFRLmEaHbN5nJrRxgRM5AEhrHp9Z/AvdNEavtlmSU38R/JhtPCvYEi?=
 =?iso-8859-1?Q?5XK1Hl+83jWCIK7FCMb+UJ6P1w8WF66WOi8J2yOnGUzzG7x252fuf7Nejv?=
 =?iso-8859-1?Q?PxXlYnvRiNNqJ2GAZh36e8v/5YZ7+bOVSlG3joIHF4jR9eoAU6jDSFfw8c?=
 =?iso-8859-1?Q?vNVezwOwl+LkV8oK6X/fxU4YPGUp7ilY5gBQU/b3u03l05cZFN/BhZM5eb?=
 =?iso-8859-1?Q?iQBQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55dab605-a150-48f2-6ee2-08d9d13bb1aa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 17:40:56.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgXfmUHM/I9zqUx0vh3lrGWneCDEAkxkRMnouZgDYej5toEpL7mZ1yW/U3V6hMknzjpWvMXDJloZG/9wzrKs3Kyn20mJwnPf95fdtIEk4Kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2511
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201060118
X-Proofpoint-GUID: 2vHIz2MWJLiQLVuiFYopCTFUHc2gAcp8
X-Proofpoint-ORIG-GUID: 2vHIz2MWJLiQLVuiFYopCTFUHc2gAcp8
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-01-05 15:39:22 -0600, Brijesh Singh wrote:
> 
> 
> On 1/5/22 2:27 PM, Dave Hansen wrote:
> > On 1/5/22 11:52, Brijesh Singh wrote:
> > > > >           for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
> > > > > +            /*
> > > > > +             * When SEV-SNP is active then transition the
> > > > > page to shared in the RMP
> > > > > +             * table so that it is consistent with the page
> > > > > table attribute change.
> > > > > +             */
> > > > > +            early_snp_set_memory_shared(__pa(vaddr),
> > > > > __pa(vaddr), PTRS_PER_PMD);
> > > > 
> > > > Shouldn't the first argument be vaddr as below?
> > > 
> > > Nope, sme_postprocess_startup() is called while we are fixing the
> > > initial page table and running with identity mapping (so va == pa).
> > 
> > I'm not sure I've ever seen a line of code that wanted a comment so badly.
> 
> The early_snp_set_memory_shared() call the PVALIDATE instruction to clear
> the validated bit from the BSS region. The PVALIDATE instruction needs a
> virtual address, so we need to use the identity mapped virtual address so
> that PVALIDATE can clear the validated bit. I will add more comments to
> clarify it.

Looking forward to see your final comments explaining this. I can't
still follow why, when PVALIDATE needs the virtual address, we are doing
a __pa() on the vaddr.

Venu

