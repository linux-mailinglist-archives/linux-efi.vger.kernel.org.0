Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE2548A1B4
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jan 2022 22:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343887AbiAJVSt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 16:18:49 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41258 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343855AbiAJVSr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jan 2022 16:18:47 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJleJM026231;
        Mon, 10 Jan 2022 21:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=cLrznidG8a1nqSv53xW1ymfinB46mQSE6A+Sxce2x6k=;
 b=RHgOverChnYyE7irn/hG4fWZhC2e/VxLzONJy1vVqtiNhnVsKgvsXgTBSUnXacl29czT
 XzwpyvrizCbycu7rDurOuyDkuo0R0yDhWKH4nCIBdh16wcoCzYj3fjRB9nVdwprkMQ/f
 8gz3YjfZm0jSd+ribMiKOVLz7QjceHXW1qQ9bnbKeo11wwavgk73/YfMepfKm0GgHB54
 JmusuG8cwTDlMRY5ODfiBB5Gef56+ZJgiMxCBOUHmQ0Xvof8Iv3GV4L1LTi4izZ2DxWX
 bxRq6Jx4bO2FSOkLPiPvcR/LMBttuLfqQQIdglXff+JfxoO5sPG0o2VbFBfjsuryjJKq gA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtg9pv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 21:18:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AL1voe146405;
        Mon, 10 Jan 2022 21:18:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3020.oracle.com with ESMTP id 3df2e3u6s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 21:18:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFGwedCgFuf4Cywq2tvBqP82drtpSVJE1y/GxOtCTGXUqLAHmCfDta9v6m3HvABg1u0vzJioOsMh1LOG2AtmzliP/SSnJgDnpcaUcblDF9hX+T+nPotj9EodmVfpIyb8yr6gM8BOB2M1snw63pWMfz0D9ojYwZgezEG+yOQm8LNyScNTEMfDsCdwoIkJrLZmN/5jriFBU5tQrDshkM3qyJ14XvJfacLuzN4YQW3IwRZEMVA+mOWhpOAQApnRDokXO5q653OSAliwwwRkLytGVmlAM2/Fu4OA77jY1ChzDM0L41sp5kKOIwhJdM3iTCecuFDrdFWPEYH4sz4ibUv9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLrznidG8a1nqSv53xW1ymfinB46mQSE6A+Sxce2x6k=;
 b=eQ+PznLs8RT0f8/X/v3e9XzPK3TB36RH9f7SCXtEgJKHYBU0kws56qH6jzZ1Chg8b2YsLWkdteo0xzBKkIooIr7qYsud2Si/mODLEEx2wk8NBsPTFJ7N2fUBZe+s3e0q+awk5TAAuquZlL8ryTP5nJz8VJ9ED0svPmqzq9BWt9g+FaJeoe5pCvNEMqLgMqOshwHDAdzD40IqiaDZAD7vEsvjf2vNEjrM9O8HCkQiS3QwheZusgFQstr+82uyN8XT7KIwGH93KstV9e2p6KXuikXeKqw9rJK+nyEuywmfXSdz/W0nUd86LV3RqqALKVsIPPut53Ej+LYrYPkz10wJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLrznidG8a1nqSv53xW1ymfinB46mQSE6A+Sxce2x6k=;
 b=ZKNDnIaESjnu6jvrvSIpLSH7pJnaiAlA+Y1GiJyrgKlaV2nE49IyVa4FfzgGBwpTvh2E1Zho3F8zpPzyfY9yfINUoyHOvFc4YW+1OtJdWBUoUdJVDdo7S6toeUdDadMo0Ew39Iy4Wm8WCD/6T5WXFoVmLNKx+hpaWuMjqlaHubM=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 21:18:09 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 21:18:08 +0000
Date:   Mon, 10 Jan 2022 15:17:56 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <YdyihO2pEE/MWsIT@dt>
References: <b18655e3-3922-2b5d-0c35-1dcfef568e4d@amd.com>
 <20211215174934.tgn3c7c4s3toelbq@amd.com>
 <YboxSPFGF0Cqo5Fh@dt>
 <Ybo1C6kpcPJBzMGq@zn.tnic>
 <20211215201734.glq5gsle6crj25sf@amd.com>
 <YbpSX4/WGsXpX6n0@zn.tnic>
 <20211215212257.r4xisg2tyiwdeleh@amd.com>
 <YdNKIOg+9LAaDDF6@dt>
 <5913c603-2505-7865-4f8e-2cbceba8bd12@amd.com>
 <1148bed5-29dc-04b2-591b-c7ef2d2664c7@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148bed5-29dc-04b2-591b-c7ef2d2664c7@amd.com>
X-ClientProxiedBy: BYAPR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::43) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba8e14ca-1351-48e2-e248-08d9d47eb31f
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB5711FBE4B7F6EC6B16EA0A05E6509@SA1PR10MB5711.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWsVLS14/zKALLSeP3hDZv9GYQSwZAvDiSRhXV4qd0y8DGGnlckzMxegIXHVeYAVBD84vdDWpazBhDx2Chi6/dmSUIoBgmDUeFePRCkUp9DkgejkUKKZWxP7qFMVZWGgrDWxFoEuD/Yy4fWEUtixeudzwiEGWg7cck/h7frxrQEdjWAIdm7aKc1mq97SLsGZsRV+DGNdeD+CPdGTW7UXPB2ALUYme7Cr0FFBdRLs+2aefT5pr51Rxszp0OgRJGmxSh/gfbwHgXuOPyJan8B+H+sy545dk5WhhSES4bqzBoLsTnooZri6Gs86OBBstX1d5ENUjL9Es4/dx2SMXK1BQWuAVk0SiqbtyIFITTiDRhskqPpNkSAeOlzlymSuDsO9lTicBUn80oDUGOTgCYUyf6D2E86oBvQcUQWEPs+5vCMsQb4FsOtlfRgBkoLc062KFVUWTmws0Jzp3M1C4TG5tzMOzT8rDnIKUeJHhqbzS51Fr6n3AGZSIs4VPkdPBEVQwRBY5vAO6J3jPyQMV0EAp79kSGmpcX0g8tGufGVJ3FHpKoaVwhw7a38dDwpvqmdprWGMp6+dGqDEEpKrxgimKSjDgSoqaRrKIjinM7yFWNxlmxGMT+tlaUOVEMRieykWomcMLiEb9QQM10xECxhexw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6486002)(54906003)(8676002)(86362001)(6512007)(9686003)(6666004)(38100700002)(316002)(186003)(8936002)(53546011)(6916009)(6506007)(33716001)(26005)(83380400001)(44832011)(5660300002)(508600001)(66476007)(7406005)(2906002)(66556008)(7416002)(66946007)(4326008)(4001150100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yZbfBDRIbMCHe1UpXQK8DZJGV/1sWo27Go6iIHFufxoEjNmLAAhzXtxgN/sn?=
 =?us-ascii?Q?4MjIHLiqi7UUQq+IZQ//AqkPbwlsmb+tDarbxgX65UQwL06gAvade4sZU+OL?=
 =?us-ascii?Q?5JYMdMYsNR5mFFxxHZjeM6FpzhxM5N75/dg3TQRnvTc4qhl9fVdtV3yQ9PLt?=
 =?us-ascii?Q?p9la10pNMEKdYS6z8qEuwywHv/Rv8GEiSf+y+zDVj54TjDsichwUxl1Xmu77?=
 =?us-ascii?Q?VIbZi8rxdAu5p9NfuweAXaZcQhZBLvftEC4S8gc35uqR2Zk12byzWpDsUrz3?=
 =?us-ascii?Q?wkZ+XIyheIQX/Y0aUvVtnEnTvrKGB6xOPWcd7BF+jiL+j4u/wkVtB5VAWir5?=
 =?us-ascii?Q?pj1n6dF9xMf0+3UC4OrMjOdPrjflU63Qt56kEHO/AYjuXlM8uOFgCEVTje7R?=
 =?us-ascii?Q?cH+oY4jmOVUAVKLIAHXLPE6xhawYtVtiW6S3O0LCFylp4EesIqROddNpzGMc?=
 =?us-ascii?Q?8TvHpeNx9PkyaGRoHiLImx5wzUdQN3TjOPiINBQW26SjJo4PFQxl76IqYwBH?=
 =?us-ascii?Q?uGeOjqgxYXsk1l2xWNT6VAk9ZaAKAA1rZ5YcHlIa0Hh8aTGdccIku0ukWi+0?=
 =?us-ascii?Q?soyqThagYnJs5VgQLcyIgkwIe8E4G4Lu8x4t6muIbKv8oSXMyMkpfIpQkcrt?=
 =?us-ascii?Q?khi/pz8QM3SqfRw4puG/pBjJPlmp9ZMQBlOFoPkeQTsBALIUdrUmW3cPFRiB?=
 =?us-ascii?Q?ttdOkzXYYDwEIQC7C24cIZuNrC3ZVAKHASTtbkdFfz27xuUzImtzG8SNMCRm?=
 =?us-ascii?Q?8Vi1RLXsnML6DL3fsuBCQlEfWdckntZT1eUQ/v7/hS6huXQ+fGv2qgow2aTi?=
 =?us-ascii?Q?cQjHGzW6fW0NqynhzUJ2yqBmxqf06j2dCnkMo23lCyZ4fLT0o8z7IPCQBahS?=
 =?us-ascii?Q?83H9gyoD9jRsedsyAJjxLFfbHglXPrahGD8d2k2VfTBszd/zPeFYDYx/tlpG?=
 =?us-ascii?Q?ewJPoARt9ZWtxrzFMJMUW+TjrdckW9xlvBMaw+VgN75Hs+y8XwKmxnZcYURi?=
 =?us-ascii?Q?JdAv1+HsMlyDX+tDSFZW4AOYDRFpQA8t4mkGHCV6hXb+3+/xlzgbeppkNFqc?=
 =?us-ascii?Q?qA6fSWxfU3BCSfx0iCWbNBeLYonYnkaFlgtnHanMlVIo++TJfn1ZWjU19Jhq?=
 =?us-ascii?Q?pa7b3LDKCW3sy1zi8JBE7cYl1AGn+NeAmYy5SgYfFIlETypRiWYnR8owD+z2?=
 =?us-ascii?Q?621vyUQRljuXRW5QadivifYQw9ITg5iCoV7h5i/hkJiPHQIQ8JA+xy9A2Y/m?=
 =?us-ascii?Q?trQOXee7jqhBB7cxGiwXmsIvV9vKrSgyoG5VmnyPtXZOQYdsdVSIPpG3hwoS?=
 =?us-ascii?Q?UPs8CS2rEVtZX8u+2otqU+VL+DoqMbKXIb7g/l0X0FP5ZPPzZPSTCXUS6Wbf?=
 =?us-ascii?Q?Ikhe19Pn7gE+kIjRildIkocZiEgmjIUPY7EFvyaHo1DICTHqXoizjBrJHY6I?=
 =?us-ascii?Q?oNtIwnA5ZcC5At4CBkhYt0e27h2J/8OLGGrW8zqECEM1OzeH/GaTQgL6BmRS?=
 =?us-ascii?Q?4RTJQH22UfeNgj8raGWl8sgROS4de4w9WrXyoozahGw5EjSmD0YrScF4/SKU?=
 =?us-ascii?Q?0ox8CBRLZDSa1gBdUIpY7d1O4AVJcRTo7jomBz4eKuT20kOcLjnhX4qljID7?=
 =?us-ascii?Q?uliyFrEV2k4VLxB5K4rNca4d+tJRfnsn0GPfRBfmriApBOunAFD2n0fQcym7?=
 =?us-ascii?Q?x7glig=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8e14ca-1351-48e2-e248-08d9d47eb31f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 21:18:08.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AYbdDTok4IxDmEmYfLqEdqcQAqoAYp1/nyNDugC7Hjejqz74uGiuu639mt86BbCkYFEFhr+yuDPcgEiT67ljvK6kzvBvT7jXFtmloEvRyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5711
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100141
X-Proofpoint-GUID: BwOcY2d-InEPOb9yzSmMVPznIGbi2Grv
X-Proofpoint-ORIG-GUID: BwOcY2d-InEPOb9yzSmMVPznIGbi2Grv
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-01-10 14:46:27 -0600, Brijesh Singh wrote:
> Hi Venu,
> 
> On 1/5/22 1:34 PM, Brijesh Singh wrote:
> > 
> > 
> > On 1/3/22 1:10 PM, Venu Busireddy wrote:
> > > On 2021-12-15 15:22:57 -0600, Michael Roth wrote:
> > > > On Wed, Dec 15, 2021 at 09:38:55PM +0100, Borislav Petkov wrote:
> > > > > 
> > > > > But it is hard to discuss anything without patches so we can continue
> > > > > the topic with concrete patches. But this unification is not
> > > > > super-pressing so it can go ontop of the SNP pile.
> > > > 
> > > > Yah, it's all theoretical at this point. Didn't mean to derail things
> > > > though. I mainly brought it up to suggest that Venu's original
> > > > approach of
> > > > returning the encryption bit via a pointer argument might make
> > > > it easier to
> > > > expand it for other purposes in the future, and that naming it for that
> > > > future purpose might encourage future developers to focus their efforts
> > > > there instead of potentially re-introducing duplicate code.
> > > > 
> > > > But either way it's simple enough to rework things when we actually
> > > > cross that bridge. So totally fine with saving all of this as a future
> > > > follow-up, or picking up either of Venu's patches for now if you'd still
> > > > prefer.
> > > 
> > > So, what is the consensus? Do you want me to submit a patch after the
> > > SNP changes go upstream? Or, do you want to roll in one of the patches
> > > that I posted earlier?
> > > 
> > 
> > Will incorporate your changes in v9. And will see what others say about it.
> > 
> 
> Now that I am incorporating the feedback in my wip branch, at this time I am
> dropping your cleanup mainly because some of recommendation may require more
> rework down the line; you can submit your recommendation as cleanup after
> the patches are in. I hope this is okay with you.

Can't we do that rework (if any) as and when it is needed? I am worried
that we will never get this in!

Venu

