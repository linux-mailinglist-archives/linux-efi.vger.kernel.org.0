Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172883F2D2F
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 15:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhHTNdN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 09:33:13 -0400
Received: from mail-co1nam11on2072.outbound.protection.outlook.com ([40.107.220.72]:58721
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229829AbhHTNdL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 09:33:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVTOj/VujymBa6S/G8M702M2M+sn4i4PSaF36R9JVDX8xqvypB4dt1bBY9bCfow+Qp1RWCkd/9D2lMNARUxsYQpESWE3BuG2RT7VurqxOb/X0BKtK3P0tcVdl5VqWbPOr5alTdACXVeVw52JmCwjHM1q6AXB1UUHsRk3hFVhwfgmQ9DP6YgqFg+xquNmtwaEqLddV4kCeoCqykUTsXrtYFjg8GZljtCCv9v8Tv1U4+R2C4si1sPRCkk8nRp+MJ0f0MuaonWBF/m2Oe4n57pQ77VFjGpw/otiW4A4a8EKJCK0V5Fh4rDpTvYcURpUBUMGnNgW1U/moI9Ai2ehcSpCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a95gJk+SgDwaoGQzpIk3sL1O7mJ6FgQFRTWINhTDJeI=;
 b=ew0q337x5pWnjitSaiSpAwd96yXKWZSYyyvcqfnJwNvMWT60OicJftA4nwc+av61gT3YKl3OVzKAu0dUBGZ+Zn6UgOnr0YLb3dAFkWPZzg8ckmU+QdK0EXhapwiSG6CahHAG0ukBfsTuTT6zOm0lTKUMDcMKsue058QWFNlNKl3Kabfp9aGxCrWUQ1mbnKFtvNckB3w65Y0P0derGJHO3rAi6b1FEUQ1FFPLdwqzxVHbry2T+9R81QTeXTn+TBIhjkrQyYFl4rKvybH9KzmU3W9vWW/3GyVGqorK0MWdepncnE29BoCGHOciaAgsLmGbmQQZXjVywRGyAQy9BVrReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a95gJk+SgDwaoGQzpIk3sL1O7mJ6FgQFRTWINhTDJeI=;
 b=0c8nwf5xZK5CVmKAe1/5h5FTeMvttE3gmcU5FOq8XyQdRoFZTbft/foX43uG+ANtJhMPDHAvt7w+T4uQLFnknAMFM2PWeViFYP4xdJCdhShGBAJzaLcDBXTP7nBx6IOTe2bqvqaLgzcW+/A4LuivscEwSsvFXalYP/ia2Xk3NGc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 13:32:31 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::491e:2642:bae2:8b73]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::491e:2642:bae2:8b73%7]) with mapi id 15.20.4415.025; Fri, 20 Aug 2021
 13:32:31 +0000
Date:   Fri, 20 Aug 2021 13:32:23 +0000
From:   Ashish Kalra <ashish.kalra@amd.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srutherford@google.com" <srutherford@google.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] KVM: x86: invert KVM_HYPERCALL to default to
 VMMCALL
Message-ID: <20210820133223.GA28059@ashkalra_ubuntu_server>
References: <cover.1623174621.git.ashish.kalra@amd.com>
 <f45c503fad62c899473b5a6fd0f2085208d6dfaf.1623174621.git.ashish.kalra@amd.com>
 <YR7C56Yc+Qd256P6@google.com>
 <B184FCFE-BDC8-4124-B5B8-B271BA89CE06@amd.com>
 <ED74106C-ECBB-4FA1-83F9-49ED9FB35019@amd.com>
 <YR7mDlxJyVkSkCbO@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR7mDlxJyVkSkCbO@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN4PR0501CA0032.namprd05.prod.outlook.com
 (2603:10b6:803:40::45) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by SN4PR0501CA0032.namprd05.prod.outlook.com (2603:10b6:803:40::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Fri, 20 Aug 2021 13:32:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b6ae8c0-37f9-4c80-1b16-08d963def621
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24475DDEE2592974CACD6AF78EC19@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18hhAmubpYERhVvoorcbD6+rKVESmDcwDC9FpZb1T9blsFnfkRh+cCJto3c/4+Ai+wnST5utAGj5n5uHHr/BeDxAyyoc6iGrdu5WooqPzY/0xINOmDiBCM/dBpFw+g9jsrGd4ZN6eooCLQlmjieVXF51cMv1r2R9+r0ra+I19HdYhywM9qdIVXs6xcgFE68S2QJOy1LEfaPAm4qJI5uvuA940ls7fbjZisJheuh0iG7X9NMQa0m6Pz7y9/Jr2gQyPKBTfl+YmPNCNPFuS71FtTLMBySttVyGTdzImLrv6BaWz/Q2UURqbGrIgXKe/kZbni8BAQcEqPJlSSPfNi0ar9Fmtr2igHkB8BDN6UFlVil56SpaBfbd97z/IroZuzjGVxiRkK54215keR3rsV2akl4kX7CglWLcR9Tr8aAeiftHKKKSanVUJ/n6xvIp1xZna8Xct+hmmXVsX+7njqYml2cZkmQlSp46pKslmclKVKs/RWk6e5TXqHNncRTWy1SpzzJrqA33jvAX1ux9isUgTsFUGzNd+7bMRkCD0lcckrntfMyLAu1J4L187rBaPG8TrhP3EkIMFERfuJKWhb/Yrk7N904eBF0tXY2O3omOjVlSgHFc9GBk5JhiAB7YZ5u8u3or4YFi0CDGsLuRSA3dXyMJFc+jtrxyGnHGxHtJGut9/QfkrIeGyppIVoTeV+BdrTEguzOUhJBf8ObcuqVP3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(6916009)(38100700002)(9686003)(86362001)(956004)(33716001)(6496006)(55016002)(53546011)(52116002)(6666004)(38350700002)(1076003)(54906003)(44832011)(33656002)(8936002)(5660300002)(316002)(8676002)(26005)(7416002)(186003)(2906002)(66556008)(66476007)(478600001)(66946007)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FqD6qpU+F2PQX2ANZsB5xOVYXw8CZb8IESfsvQoCEb3HMfBL+S8RmDbDR6tE?=
 =?us-ascii?Q?R0Unddqn5H8ffDLnsWm2VFao9azzwP+EKeVm7e+956GKP7N+hQHNlmiPR9K/?=
 =?us-ascii?Q?v8YQdO3eDFD/we3Q6kCNirJ8YZVg1m2iDxkUASyKR6s+lDoRIl3Bsolvh+St?=
 =?us-ascii?Q?HDVy0jd2+rrz/QHH/6UNnEn5Dl2TPHdv3Yi7+LmRZ6FRtPoAvBO2NGrcZUWc?=
 =?us-ascii?Q?0Oq6jEiSnYGtCBzhKuF+4Yu3pzy3+BvC+ijDCuyaDugwuYNhDiziCJ60sQHy?=
 =?us-ascii?Q?YKTIZ3Flzrqons8t1fD0yEto0lOqCJ9fUBdeYosU9fkSoQeOV5r7yROeiUhv?=
 =?us-ascii?Q?/MGUSlI0P+ZfOpug3kAXS5gdYfT9910+vCLLcpF4bUt1KKa4PmGu9BGLD4bq?=
 =?us-ascii?Q?u8hZ6AX6F8bCErsVAKxxcMK7gJ4wD6LHKNPZFO6v4dqcLAbxgtI8b7wrwMqb?=
 =?us-ascii?Q?X1NyCvy6g+wD84vjt/XXBdhdQghC02kgYujrwlJyLidzLdnMeirkRrp1hwy8?=
 =?us-ascii?Q?kEvlbcJgsX6aPTV1KUFzuHm0ApRezTShN1qzkbI+UDcGSlMWatsRk+hAXGow?=
 =?us-ascii?Q?zvrXGdv2hTV42qZxc2piIk1nPKwysx4agLpxl3TdCI1+b5TZnL409t1p/3na?=
 =?us-ascii?Q?Oh9rV2go/yzOPLY7ChgDkQrvcemHwRN5aPK0l3ho/vgIhq3rUnPi99dLZ/qG?=
 =?us-ascii?Q?a4HVHHed3lFhPDEUs8ZDTuvKenk0tSOzlXxy76XEqK6km/thg+YZen3Wa2aX?=
 =?us-ascii?Q?TiJps9NNDEqBnewkv3bISAlhf30o7A2ERGAOvQzPQvUqeH8zyp6htb8edygs?=
 =?us-ascii?Q?pTN1khys7HI2OfpbwBkNk+p89GpPnLCNUid/Pn7ig094tLBJRSpl5BthBqyL?=
 =?us-ascii?Q?wJA7EMdDRtTgW/0/i9Uugp4Pjx1hqy8QgHwXTFkE7pZJM2bJrvM1PJccJ+uK?=
 =?us-ascii?Q?N3sn4kyoeG8/CxX7AbKZP7udZ39jfWrXQLaiAmmRbiHO+dhzMB/wGsU0nTwh?=
 =?us-ascii?Q?+Q920lXr/LJQB4TSEnVIj7sw78dNSSgvmJHNgNW2xqHY33/3Zik6p3m7tLE6?=
 =?us-ascii?Q?e1UamWLezJIWpd15pVjLg6jsWOIJRXAx32mOat0RnVTnIcXjzwSyc7qu/mHS?=
 =?us-ascii?Q?kA2Ph7ULCpRLoqo0TPWxK7mUzRwkZmue7MrWLy0fUngbk+gzjqo/aP3QusYX?=
 =?us-ascii?Q?4cqdt1CHt8MvgPk5CDrSlaLd2a0UhQLrpR1ryrPyEq3Ousby4IjdlW0DJmS9?=
 =?us-ascii?Q?CdL5YPAD1rZe/20q8MsXqil0vRUzEWGcGCpo4XUJQxaWP/gNw0H/HXiC2Y/1?=
 =?us-ascii?Q?l14E1FxuLde+9MLi40vM2Rtu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6ae8c0-37f9-4c80-1b16-08d963def621
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 13:32:31.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VnXs0qa051zXnP9hq+GOeJ3lXzsnCdbp32WimK1SdwWvd8G7Wd7RTrongBLXMgOM054kCB4V3HBDahQV3r7mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 19, 2021 at 11:15:26PM +0000, Sean Christopherson wrote:
> On Thu, Aug 19, 2021, Kalra, Ashish wrote:
> > 
> > > On Aug 20, 2021, at 3:38 AM, Kalra, Ashish <Ashish.Kalra@amd.com> wrote:
> > > I think it makes more sense to stick to the original approach/patch, i.e.,
> > > introducing a new private hypercall interface like kvm_sev_hypercall3() and
> > > let early paravirtualized kernel code invoke this private hypercall
> > > interface wherever required.
> 
> I don't like the idea of duplicating code just because the problem is tricky to
> solve.  Right now it's just one function, but it could balloon to multiple in
> the future.  Plus there's always the possibility of a new, pre-alternatives
> kvm_hypercall() being added in generic code, at which point using an SEV-specific
> variant gets even uglier.
> 

Also to highlight the need to support this interface, capturing the flow
of apply_alternatives() as part of this thread: 

setup_arch() call init_hypervisor_platform() which detects the
hypervisor platform the kernel is running under and then the hypervisor
specific initialization code can make early hypercalls. For example, KVM
specific initialization in case of SEV will try to mark the
"__bss_decrypted" section's encryption state via early page encryption
status hypercalls. 

Now, apply_alternatives() is called much later when setup_arch() calls
check_bugs(), so we do need some kind of an early, pre-alternatives
hypercall interface. 

Other cases of pre-alternatives hypercalls include marking per-cpu GHCB
pages as decrypted on SEV-ES and per-cpu apf_reason, steal_time and
kvm_apic_eoi as decrypted for SEV generally.

Actually using this kvm_sev_hypercall3() function may be abstracted
quite nicely. All these early hypercalls are made through
early_set_memory_XX() interfaces, which in turn invoke pv_ops. 

Now, pv_ops can have this SEV/TDX specific abstractions.

Currently, pv_ops.mmu.notify_page_enc_status_changed() callback is setup
to kvm_sev_hypercall3() in case of SEV.

Similarly, in case of TDX, pv_ops.mmu.notify_page_enc_status_changed() can
be setup to a TDX specific callback. 

Therefore, this early_set_memory_XX() -> pv_ops.mmu.notify_page_enc_status_changed()
is a generic interface and can easily have SEV, TDX and any other future platform
specific abstractions added to it.

Thanks,
Ashish

> > > This helps avoiding Intel CPUs taking unnecessary #UDs and also avoid using
> > > hacks as below.
> > > 
> > > TDX code can introduce similar private hypercall interface for their early
> > > para virtualized kernel code if required.
> > 
> > Actually, if we are using this kvm_sev_hypercall3() and not modifying
> > KVM_HYPERCALL() then Intel CPUs avoid unnecessary #UDs and TDX code does not
> > need any new interface. Only early AMD/SEV specific code will use this
> > kvm_sev_hypercall3() interface. TDX code will always work with
> > KVM_HYPERCALL().
> 
> Even if VMCALL is the default, i.e. not patched in, VMCALL it will #VE on TDX.
> In other words, VMCALL isn't really any better than VMMCALL, TDX will need to do
> something clever either way.
