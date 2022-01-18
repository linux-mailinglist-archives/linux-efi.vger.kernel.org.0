Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33949492DD7
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jan 2022 19:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348352AbiARSt6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Jan 2022 13:49:58 -0500
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:64609
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348350AbiARSt6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 Jan 2022 13:49:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIrDkI+P3i+HWecFwByFCWm1zNyT3vPWtaDz+op4Di6Qz8j664Cr47hlOj0Ej/yvaOpXsqLvyVI4moXab5Jl23wMAhm+qRo5p59HtZqAk68ATH+htjBt4WR+eSlCTprxEnBd78yE9ch6mOh9OCQ3XPzzTP2lBWFXtIsdECAZ0YKuzohfoarl0YIIvoGkrd0cFagVIqh32LGmIyI5tmgTn0kpgSfwqXP/YfkdONaUcZvnkdNNwkAgsAzwPKpJZ/Twuii1av9By0VDj/t9Bq5V2ibniN/0ZbEvYdsIAiAZ/dxB2YgneiIJi4Ph6+POj38sgHkyLA04MRxnV7Yx3DHsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rm6RfnVFU9PedM6Tlj4u6ujyouEdaJOUch+l1HxO2kA=;
 b=URomINE3vnE8fdydF7bs4dkoObZxgX1m8fTxi0mLsO+GRbvL6UPxId+PuLIdPRfHYyQWlHKS5qYiY+nDrMk4oWZDaTyggozijTyCz/dWP3YpCj4WwqtMpSSEJLCN4sKAZEpVRxFZ7060DDl+uvSO6ypXStRuIpoRChzlqXBEqEZ/MiuO/QOdT5CtxFwUlAjCYmpLwoid+o6EIwXAauIJROmK7uaMMl2Z48qp2kD/9prOr7Jv2MNXkeGUh5tHpKxsIpEhcibkiBDjk9IuAohXLnX12nsRHQvDhZA6YZ3LAvGMIf0MH9cHU7Iq2dFrTOAlywymuo4Gho8bFWhxV524yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rm6RfnVFU9PedM6Tlj4u6ujyouEdaJOUch+l1HxO2kA=;
 b=i4z3vh/8LescZ0EY+UtY2bwQmeXWCtA+Sc6YuQCzyRWfzbnR6zJZl6SfNN3/JRCoIX6PgBxVbIYcV1A8Gp3yIaRBQJ+MIrAaJ9/K7GEt+NCIxMTxx4lAfesZpD3i/jO/l8w0Yr5hyMfOdCKug3H3AZRGZG2bBZfK188gp9cu6ek=
Received: from MW2PR2101CA0021.namprd21.prod.outlook.com (2603:10b6:302:1::34)
 by MWHPR12MB1742.namprd12.prod.outlook.com (2603:10b6:300:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 18:49:55 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::63) by MW2PR2101CA0021.outlook.office365.com
 (2603:10b6:302:1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.3 via Frontend
 Transport; Tue, 18 Jan 2022 18:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 18:49:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 12:49:52 -0600
Date:   Tue, 18 Jan 2022 12:49:30 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Brijesh Singh <brijesh.singh@amd.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 29/40] x86/compressed/64: add support for SEV-SNP
 CPUID table in #VC handlers
Message-ID: <20220118184930.nnwbgrfr723qabnq@amd.com>
References: <20220113163913.phpu4klrmrnedgic@amd.com>
 <YeGhKll2fTcTr2wS@zn.tnic>
 <20220118043521.exgma53qrzrbalpd@amd.com>
 <YebIiN6Ftq2aPtyF@zn.tnic>
 <20220118142345.65wuub2p3alavhpb@amd.com>
 <20220118143238.lu22npcktxuvadwk@amd.com>
 <20220118143730.wenhm2bbityq7wwy@amd.com>
 <YebsKcpnYzvjaEjs@zn.tnic>
 <20220118172043.djhy3dwg4fhhfqfs@amd.com>
 <Yeb7vOaqDtH6Fpsb@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yeb7vOaqDtH6Fpsb@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfcca906-b973-460c-a832-08d9dab350e3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1742:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17429DCE980B42B9AC37820B95589@MWHPR12MB1742.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2Yf3IIZZH98M8cp3jwK2l74r9mdmfX0pAA7LJkqVQ0ibpAY4/97BTa132WGJHNophoTT2awFZdVMwcdx/TPROoENd/jfxnRqV0AzGz7rEwLlohIidT+YNicmgY52AFDBhzz2EOzn6L50gFDDZQ3L3uJoUJkEX8yr409Tb2/CyJ5xRDGoOo5e2TVlWXv4ecdJ4QmO+cT9IPe3j90GjKFiElLDcQqiJNhY9y/4UUzv7Vehuh79O/XW/wwjtyzcm/TDE4J4RujL+yYrhFOcodDPyR/wOhvQl1zWIuNDa7eXrRYcea+n1hbh04/esaLvVZF1cEtjGyUFSBswqT4L+tcKoa7ijkYVl4uuxsjbZkzB+71jIs3ltm0vST3i6LiBh9okGbiSFA8kpTFBECn6S63FnDwr3pb2otjkyvWim/Me+keBT5SLv8zdEUVCd2nW4jQdPKpnsLI9Gw8ayAqNQbi8WbtsLTfr/SzWTHawTey8XEN9XjcV4FcVbmngBh3DR8xw4PZOlfDE/5ygZj3+1thQLJPFGCkWhRSDqax9xdEPt5rX7ms7heOjwGOekd7n5SLQcQdL4kl4HQBxleyZbcmHXX72Ap3d4IEsbAyfEt3/RiHRpobzvlEV7G4VJFsk+4opToexYMwjma5zEVA27ohqRSNh0rQohk4W1zpetVhZkLmDARAM6kZj/rbGiyFe7Fxrd4OaJAPtCOTc1obUczRgR7bIgwAkExUpMsdjpU+32Zk0B2azg0iEa6Dcy2mUXQQTlBUuhz2M9xldsoLLQac13SuQejN9w1O6sNgXYx1BMVwh7TLsapnin9hEj3/QPgsRricEFKBl15USBzf6zZXFmYHOkoKz3QkywqsK1mcoRAOUvUbDw183xKPp8FhX6R7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(16526019)(336012)(426003)(45080400002)(5660300002)(2616005)(81166007)(54906003)(186003)(508600001)(83380400001)(40460700001)(36860700001)(86362001)(36756003)(47076005)(44832011)(26005)(7406005)(2906002)(1076003)(4326008)(8676002)(6666004)(70206006)(82310400004)(6916009)(356005)(966005)(70586007)(316002)(7416002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 18:49:53.9015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcca906-b973-460c-a832-08d9dab350e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1742
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 18, 2022 at 06:41:16PM +0100, Borislav Petkov wrote:
> On Tue, Jan 18, 2022 at 11:20:43AM -0600, Michael Roth wrote:
> > The HV fills out the initial contents of the CPUID page, which includes
> > the count. SNP/PSP firmware will validate the contents the HV tries to put
> > in the initial page, but does not currently enforce that the 'count' field
> > is non-zero.
> 
> So if the HV sets count to 0, then the PSP can validate all it wants but
> you basically don't have a CPUID page. And that's a pretty easy way to
> defeat it, if you ask me.
> 
> So, if it is too late to change this, I guess the only way out of here
> is to terminate the guest on count == 0.

Right, which is already enforced as part of snp_cpuid_info_create(). So
snp_cpuid_info->count will always be non-zero for SNP guests...

Er... so I suppose we *could* use snp_cpuid_info->count==0 as an indicator
that the cpuid page isn't enabled afterall...since if this was an SNP guest
then count==0 would've caused it to terminate...

Sorry I missed that, early versions of the code used count==0 as
indicator to bypass CPUID page before we realized that wasn't safe, and
I'd avoided relying on count==0 for anything since then. But in the
current code it should work, since count==0 causes SNP guests to
terminate, so a running guest with count==0 is clearly non-SNP.

> 
> And regardless, what if the HV fakes the count - how do you figure out
> what the proper count is? You go and read the whole CPUID page and try
> to make sense of what's there, even beyond the "last" function leaf.

The current code trusts the count value, as long as it is within the
bounds of the CPUID page. If the hypervisor provides a count that is
higher or lower than the number of entries added to the table, the PSP
will fail the guest launch.

count==0 is sort of a special case because of the reasons above, and
since it is never a valid CPUID configuration, so makes sense to
guard against.


> 
> > So we can't rely on the 'count' field as an indicator of whether or
> > not the CPUID page is active, we need to rely on the presence of the
> > ccblob as the true indicator, then treat a non-zero 'count' field as
> > an invalid state.
> 
> treat a non-zero count field as invalid?
> 
> You mean, "a zero count" maybe...

Yes, sorry for the confusion.

> 
> But see above, how do you check whether the HV hasn't "hidden" some
> entries by modifying the count field?
> 
> Either I'm missing something or this sounds really weird...

Yes, that's my fault. count must match the actual number of entries in
the table in all cases. If count==0 then there must also be no entries
in the table. count==0 is only special in that code might erroneously
decide to treat it as an indicator that cpuid table isn't enabled at
all, but since that case causes termination it should actually be ok.

Though I wonder if we should do something like this to still keep
callers from relying on checking count==0 directly:

  static const struct snp_cpuid_info *
  snp_cpuid_info_get_ptr(void)
  {
          const struct snp_cpuid_info *cpuid_info;
          void *ptr;
  
          /*
           * This may be called early while still running on the initial identity
           * mapping. Use RIP-relative addressing to obtain the correct address
           * in both for identity mapping and after switch-over to kernel virtual
           * addresses.
           */
          asm ("lea cpuid_info_copy(%%rip), %0"
               : "=r" (ptr)
               : "p" (&cpuid_info_copy));
  
          cpuid_info = ptr;
          if (cpuid_info->count == 0)
                  return NULL
  
          return cpuid_info;
  }

Because then it's impossible for a caller to accidentally misconstrue
what count==0 means (0 entries? or cpuid table not present?), since the
table then simply becomes inaccessible for anything other than an SNP
guest, and callers just need a NULL check (and will get a free hint
(crash) if they don't).

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C56a8943d73484fda82ce08d9daa9bc0c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637781244848502186%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=2QO85fJBiZt2opWRWX%2FGb5LPt4How5cuAt4UJzAiQsg%3D&amp;reserved=0
