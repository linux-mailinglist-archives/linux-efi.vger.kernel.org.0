Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1871A309D
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 10:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgDIIHZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 04:07:25 -0400
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:35246 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgDIIHY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Apr 2020 04:07:24 -0400
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Thu,  9 Apr 2020 08:06:04 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 9 Apr 2020 08:06:36 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 9 Apr 2020 08:06:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiIOWHKu+h2a7FN+QHD+e00RNruioCb+z8uNDfJ1431M589yRDqeO/GXiJC+Pk2rv5U05jexyMdXL5CI63z7fi6ccnnDZnrVKYHlNrXPNXvt3K6qF43KNos5sfoLd+zunkEark6LCZ2+LgQrjAmzjRlEyWSzIZLpT9OcJfEzv4n+wx6/WoHf1blt2RYHnJq5JgYTZRBDu8lKUEgz/SLRXstPrsiravZuVWnuFRk5Lh92t8BlvgM6wg6tu2GFnHYpWCe7/GGumThvH21uTl2U0RHp1vbGTeVM2jeHmsqz4UbJX4iU6Zts7KqKaWJr9JwbIR+gHiI2U11ogwXBheZ6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPJlMU6kdQKG6PhnpLcrgbQltS/t4B9EHBdmt1CWM/0=;
 b=fst0hdRqUdDqTSKEUOLLgNGKaJldw+UXi7bhEGPzFOolxOfndxnlGMukr7KE6B+n9NOvlalrG9i8VhB7CCMADiNIJEt/gOzjo3AScHpS/xUNefSuPJhKGkfOYGTdibhZhpLK7A4STMF2NLp2eZQfejMfvX1K2cpMI3WSYokkywY/pFlXVK9TmyJ1H3dsqAd6agw5B0LYuPgqSfceJgjmOZHTPhWXQ/1uWhj+vjmjIDmKXGb+lifLz+9o+DYwDzLlEzj4IDgavwARsBLqzlOUv6qSPbov1fHJ9aBxd3l3FUYcJynfZ1sXXxPpca8SsoXB1dOoa08Nb3IE3QHuEpg6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=GLin@suse.com; 
Received: from DM6PR18MB3258.namprd18.prod.outlook.com (2603:10b6:5:1cd::31)
 by DM6PR18MB2458.namprd18.prod.outlook.com (2603:10b6:5:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Thu, 9 Apr
 2020 08:06:35 +0000
Received: from DM6PR18MB3258.namprd18.prod.outlook.com
 ([fe80::5cdb:be43:a2bf:ca25]) by DM6PR18MB3258.namprd18.prod.outlook.com
 ([fe80::5cdb:be43:a2bf:ca25%6]) with mapi id 15.20.2878.021; Thu, 9 Apr 2020
 08:06:35 +0000
Date:   Thu, 9 Apr 2020 16:06:26 +0800
From:   Gary Lin <glin@suse.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Jiri Slaby <jslaby@suse.cz>, linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH 05/13] efi/x86: don't map the entire kernel text RW for
 mixed mode
Message-ID: <20200409080626.GV5951@GaryWorkstation>
References: <20200113172245.27925-1-ardb@kernel.org>
 <20200113172245.27925-6-ardb@kernel.org>
 <63b125a4-6c62-fcdf-de22-d3bebe2dcbf5@suse.cz>
 <CAMj1kXGiT_zYjc6X-msRXVozhpDAY0UesEW3_4fOgiH4FyMgDw@mail.gmail.com>
 <972b66a9-92c7-9a15-1aa1-e3236abe90df@suse.cz>
 <CAMj1kXFGkOM9fbqr44_TbdxqFjH1i3d8dkO64C1mQmH=AqrUSQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMj1kXFGkOM9fbqr44_TbdxqFjH1i3d8dkO64C1mQmH=AqrUSQ@mail.gmail.com>
X-ClientProxiedBy: SN6PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:805:106::18) To DM6PR18MB3258.namprd18.prod.outlook.com
 (2603:10b6:5:1cd::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from GaryWorkstation (60.251.47.115) by SN6PR2101CA0008.namprd21.prod.outlook.com (2603:10b6:805:106::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.6 via Frontend Transport; Thu, 9 Apr 2020 08:06:32 +0000
X-Originating-IP: [60.251.47.115]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e072795-bd0d-4efe-1140-08d7dc5cebe1
X-MS-TrafficTypeDiagnostic: DM6PR18MB2458:
X-Microsoft-Antispam-PRVS: <DM6PR18MB2458A1DB335510A5FCA89319A9C10@DM6PR18MB2458.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB3258.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(86362001)(33656002)(316002)(2906002)(33716001)(7416002)(66476007)(66556008)(66946007)(4326008)(6666004)(54906003)(6916009)(55236004)(956004)(966005)(8936002)(6496006)(16526019)(26005)(1076003)(9686003)(52116002)(5660300002)(81166007)(478600001)(55016002)(81156014)(8676002)(45080400002)(186003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFSTnEPd41NIa1jDjSqutHxuPAz8fWJd3EuJUcclK3ntEaEoem7lhhOZf4NArtPjOqPuRUNwSQRu94b2T2yCgB4wQ5DN917eHO+8CxTpmLJ9ZWCoE4KdfVOGa7Pj1CRu5xRpywZbmv3+Zs6FRAb2Mxe6CV290lu9Wd7Q0LJiiLM1ec6JHLM59bCPkEPlRqs0vM9E+0pGFPB7Ybd5QfgXH/OrCX2UrdUPJyBkaohVEUUme7xc0yMQPkUxg07hluRcZf91OZDDwr0c2j0zUgL+ycPhJvjhzP6i6pazf/xmu3DnKesr3fL8MfmPcylSX26TEA69FjmRqy9LUfk6k6+cMjbKI40eYWAWbMTeBTm7t6vZHVTEyVwuNeM6cxytHhLFTE/6+gYINJqmmBI0QfU8ZRy5nyHeA7APGVUJuu8DwAkI7KmTwKMzQh711HbsihVy+MuAVPb/jb27zu/Vp9TzvrIvz+u8A/lqZsXlBjqi8RgHhmryUnqFNtTgWKXUco+AAwisjw/XWqOK2VmxXLdtDQ==
X-MS-Exchange-AntiSpam-MessageData: WPT6SsvgaCpMPqpjVn6DXyhcI907y+OmJrQPFmcmvNPGBZJtLKV+XlmDCQKf/j64eYjr47TgH0ANI3fTCHNxo2VerSnLf3NY09mVmpGvVTgZu251OYvhNZAvnl4ZbH+xnukcEE2zoyVGzq9uatBXGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e072795-bd0d-4efe-1140-08d7dc5cebe1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 08:06:35.0081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZ/v9Dp98F8P01DdhMi9h7d42WlFM2flfihWn8HV40tVX+zl7yIhGRXMoM3osbHs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2458
X-OriginatorOrg: suse.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Apr 09, 2020 at 09:51:20AM +0200, Ard Biesheuvel wrote:
> On Wed, 8 Apr 2020 at 12:51, Jiri Slaby <jslaby@suse.cz> wrote:
> >
> > Ccing Gary.
> >
> > On 08. 04. 20, 12:47, Ard Biesheuvel wrote:
> > > On Wed, 8 Apr 2020 at 12:42, Jiri Slaby <jslaby@suse.cz> wrote:
> > >>
> > >> On 13. 01. 20, 18:22, Ard Biesheuvel wrote:
> > >>> The mixed mode thunking routine requires a part of it to be
> > >>> mapped 1:1, and for this reason, we currently map the entire
> > >>> kernel .text read/write in the EFI page tables, which is bad.
> > >>>
> > >>> In fact, the kernel_map_pages_in_pgd() invocation that installs
> > >>> this mapping is entirely redundant, since all of DRAM is already
> > >>> 1:1 mapped read/write in the EFI page tables when we reach this
> > >>> point, which means that .rodata is mapped read-write as well.
> > >>>
> > >>> So let's remap both .text and .rodata read-only in the EFI
> > >>> page tables.
> > >>
> > >> This patch causes unhandled page faults in mixed mode:
> > >>
> > >>> BUG: unable to handle page fault for address: 000000001557ee88
> > >>> #PF: supervisor write access in kernel mode
> > >>> #PF: error_code(0x0003) - permissions violation
> > >>> PGD fd52063 P4D fd52063 PUD fd53063 PMD 154000e1
> > >>> Oops: 0003 [#1] SMP PTI
> > >>> CPU: 1 PID: 191 Comm: systemd-escape Not tainted
> > >> 5.6.2-20.gb22bc26-default #1 openSUSE Tumbleweed (unreleased)
> > >>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0
> > >> 02/06/2015
> > >>> RIP: 0008:0x3d2eed95
> > >>> Code: 8b 45 d4 8b 4d 10 8b 40 04 89 01 89 3b 50 6a 00 8b 55 0c 6a 00
> > >> 8b 45 08 0f b6 4d e4 6a 01 31 f6 e8 ee c5 fc ff 83 c4 10 eb 07 <89> 03
> > >> be 05 00 00 80 a1 74 63 31 3d 83 c0 48 e8 44 d2 ff ff eb 05
> > >>> RSP: 0018:000000000fd66fa0 EFLAGS: 00010002
> > >>> RAX: 0000000000000001 RBX: 000000001557ee88 RCX: 000000003d1f1120
> > >>> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000001
> > >>> RBP: 000000000fd66fd8 R08: 000000001557ee88 R09: 0000000000000000
> > >>> R10: 0000000000000055 R11: 0000000000000000 R12: 0000000015bcf000
> > >>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > >>> FS:  00007f36ee9dc940(0000) GS:ffff9b903d700000(0000)
> > >> knlGS:0000000000000000
> > >>> CS:  0008 DS: 0018 ES: 0018 CR0: 0000000080050033
> > >>> CR2: 000000001557ee88 CR3: 000000000fd5e000 CR4: 00000000000006e0
> > >>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > >>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > >>> Call Trace:
> > >>> Modules linked in: efivarfs
> > >>> CR2: 000000001557ee88
> > >>
> > >> EFI apparently tries to write to now read-only memory.
> > >>
> > >> See:
> > >> https://bugzilla.suse.com/show_bug.cgi?id=1168645
> > >>
> > >> Reverting it on the top of 5.6 fixes the issue.
> > >>
> > >> I am using
> > >> /usr/share/qemu/ovmf-ia32-code.bin
> > >> /usr/share/qemu/ovmf-ia32-vars.bin
> > >> from qemu-ovmf-ia32-202002-1.1.noarch rpm.
> > >>
> > >
> > > Do you have a git tree for Suse's OVMF fork? I did a lot of testing
> > > with upstream OVMF, and never ran into this issue.
> >
> > Not really a git tree, but the sources are here:
> > https://build.opensuse.org/package/show/openSUSE:Factory/ovmf
> >
> 
> 
> Anywhere I can get an actual build? The src rpm only has the sources,
> and the i586 rpm has nothing except
> 
> $ rpm -qlp ~/Downloads/ovmf-202002-1.1.i586.rpm
> warning: /home/ardbie01/Downloads/ovmf-202002-1.1.i586.rpm: Header V3
> RSA/SHA256 Signature, key ID 3dbdc284: NOKEY
> /usr/share/doc/packages/ovmf
> /usr/share/doc/packages/ovmf/README

Hmmm, it's weird that OBS doesn't list all derived files.
Anyway, the ia32 ovmf is available in
http://download.opensuse.org/tumbleweed/repo/oss/noarch/qemu-ovmf-ia32-202002-1.1.noarch.rpm

Gary Lin
