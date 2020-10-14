Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E3828DDBD
	for <lists+linux-efi@lfdr.de>; Wed, 14 Oct 2020 11:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgJNJfw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Oct 2020 05:35:52 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:56024 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbgJNJfw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 14 Oct 2020 05:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1602668148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sogu/Q5b+Zu3f9v03p0hf6438OymlScNq/GXD/WUmu4=;
        b=Y2cL2Sp69FX8HTTR8hdavIb7ZDqdsyVbfJ/NqP0rZocdlL4xwVKoXk6xG8SuL5Ovyyx09S
        tFXQbgP2+LZI3CWjXK1o5IIRamJVeqtOTryxjC9mKZBTr4oy4jSNQwsMkulH3XJgOVLwXC
        DBQ83f/dKpOx6LXvMlID3jlsfZEIlIc=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2056.outbound.protection.outlook.com [104.47.2.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-5-6ljft_H4PByvF2f5pqk5Qw-1;
 Wed, 14 Oct 2020 11:35:47 +0200
X-MC-Unique: 6ljft_H4PByvF2f5pqk5Qw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUUEPAWRqDO+q+2gEo09WFxFUylVhwXcRpsVUZuUQWpk5XjWfdAaZ/dMn2qWP+Z05CrSgfdOGQWVdHW3IJjDzHnA4DzIdgToV7a1rCw7biTmGY3n7sipvy2r3nJMhJmDu37bnLB3X4i6R4YWarB5dwrYXrvrpB1OWNCUZNZp6LS7SBYSkxWCmv4kcXe7+ECOEzDIRx0XLTN3FY7pHhL240RKbLLL2p3kyjguSSQwZtWI9BfhufcKYOw8gIPwa8hKEL8S7I8kJyW5jETtp8a8pA1BblFcViE3gWTx+RlzPTSTmMh7wnVN0WziuEsJBkCMJ+VpcNBCUbFqvNN9sie6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sogu/Q5b+Zu3f9v03p0hf6438OymlScNq/GXD/WUmu4=;
 b=WXXgHikRMYmdHiZQZMWm6NR+YfWOxsf9BF6N78lsoqZPsfKnnXJA8jV8jJBuKMHOh9cSznFLudlFB+83OZIGILqh+dWUeN8+/0PkZV40B8XFxxJU7z21ng6PN0hbs+c+nvGAkjW6z62Xa/dQTC2sM9Q7J9izpLdVvYM+D9oSZ7kVfYAaGTwYTNn8j9g8lcPQ0yUXQJonBDGAdChMT9GXVqKOYpfKJHczf/3iDts200RKpK3DvzzMHaXCjxoPFAIQ+0GfqZ6NswckE9+zTNB1zSsEfFtZJOoYXWNddVcgRXGQvj8BnrqBbPKz7eARy+MOJ2Hi6yZrmHHn4+8CSgqdCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR04MB5150.eurprd04.prod.outlook.com (2603:10a6:803:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 14 Oct
 2020 09:35:45 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::e922:583c:a9bf:66e0]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::e922:583c:a9bf:66e0%6]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 09:35:45 +0000
Date:   Wed, 14 Oct 2020 17:35:31 +0800
From:   Chester Lin <clin@suse.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>, jlee@suse.com
Subject: Re: [PATCH v2] ima: defer arch_ima_get_secureboot() call to IMA init
 time
Message-ID: <20201014093531.GA9408@linux-8mug>
References: <20201013081804.17332-1-ardb@kernel.org>
 <ae9ab2560f6d7b114726efb1ec26f0a36f695335.camel@linux.ibm.com>
 <CAMj1kXFZVR46_oeYTxJ59q-7u+zFCFtOQuSQoiEzKLhXzpydow@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFZVR46_oeYTxJ59q-7u+zFCFtOQuSQoiEzKLhXzpydow@mail.gmail.com>
X-Originating-IP: [118.166.52.150]
X-ClientProxiedBy: FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24)
 To VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (118.166.52.150) by FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend Transport; Wed, 14 Oct 2020 09:35:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 570349bf-fc4d-42da-e698-08d870248675
X-MS-TrafficTypeDiagnostic: VI1PR04MB5150:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB515005C178C3405060D6DFA3AD050@VI1PR04MB5150.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBgBoOpRevyLtTo0Y3QKZRMkpUbGOYBcIVfX6VMK3M33rlGKinMI4ABc9fjbPOLQ9g09QpVMAIX48T0NkfIpgfBNWBD8xVrYfUQEOIlzRO6DYitId3vnf9opEAt0ngYJjDoL6uK8uFajrfAg3L/Om97sJwyEBeWmgovf7PJ45K6mFEG5l0jWlFPIbiZJ1JY/CPH8QgE0KFXYbEpY5o8Ufc7FkiCYpfozeFO0s2gpdLMXL02TEWAoqKbIkU2RSXnX34pp2RoLp6jMgG6pKFf3gKMwkuKeaFe6+JvqvpJ90xa1tVW9uDCFHlNN6aWRrB1ku3dwymV6tv9TMP/4AxtllSzVUHZI0tc6xi0zOFJlKGHhG8XPrsXUffuhLYUYieQBDVHMcBQDABLETy5TZOY2fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(396003)(366004)(6666004)(66556008)(1076003)(107886003)(55016002)(966005)(54906003)(55236004)(8676002)(2906002)(83080400001)(33716001)(66946007)(8936002)(956004)(4001150100001)(4326008)(26005)(316002)(16526019)(52116002)(9686003)(186003)(33656002)(66476007)(5660300002)(86362001)(83380400001)(478600001)(6496006)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: httdX+cVgNPMWuZpAl1VqHnIYnSCX3xlkqnCEWuMTLZXdjlRrmFVC0Z4mbNyYDlXneX9FqXo9D84IKrbzlmpPEGLQXRCvgwL+MhdqdIUkZawPLsHzl3+rWXdmpWAL+YOWZSTa8qr72JatC4ygYBJlojAI1TCwcVPNpAtaYgff6iD3RlCPUg4WdOpdbUaWlj0McVOOmlrwNPtgHSMcuMTZ/e6lnqSZII0MA2783U/NFOviXdNeo6A2UPGEvFCJsdd8Jd2GHNA5FZD8TLw+sn9BqFDhA4eaC45joB/9tP9IUWXgsFGPeC7a4XTydnyAS97HHZufei+IczctfHAYvXVy8BsAiM2GSf+1JZ3ZMDYJvLYOwM0ZvT9c5gTv+t9E++iNOXJv0kHkn4/+CQRD3C5yOoRfBJD+7/SHLep6lkdukVRyGPYzKAGKKso2AuILCQRZSEhgEKAbsicGOJUs1JEZAzHxRQVxQF9Ga6ARf2fjYzDlc5ygGbljUORUgS99i2QkFbeuqeiadMNJvhrYgAwLk0VL5irJyiQLHr3oFqNYCTyZi4lrv0GPmNTKFlBrrbu98M9AOsr/D8yxeTKjlOmE9ZS6OwR7wjonrKArHTlXxhgZeeXm2YxdhNt5jX2MZgfCs36kUtA0C7xp7jHbZldGg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570349bf-fc4d-42da-e698-08d870248675
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 09:35:45.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODqkZXYi0GU36JbCYv4RfdzwK26i32u09XnRfhh4/SSMER4Vab5gtmemH+Nf0XTX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5150
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard & Mimi,

On Tue, Oct 13, 2020 at 06:59:21PM +0200, Ard Biesheuvel wrote:
> On Tue, 13 Oct 2020 at 18:46, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > [Cc'ing linuxppc-dev@lists.ozlabs.org]
> >
> > On Tue, 2020-10-13 at 10:18 +0200, Ard Biesheuvel wrote:
> > > Chester reports that it is necessary to introduce a new way to pass
> > > the EFI secure boot status between the EFI stub and the core kernel
> > > on ARM systems. The usual way of obtaining this information is by
> > > checking the SecureBoot and SetupMode EFI variables, but this can
> > > only be done after the EFI variable workqueue is created, which
> > > occurs in a subsys_initcall(), whereas arch_ima_get_secureboot()
> > > is called much earlier by the IMA framework.
> > >
> > > However, the IMA framework itself is started as a late_initcall,
> > > and the only reason the call to arch_ima_get_secureboot() occurs
> > > so early is because it happens in the context of a __setup()
> > > callback that parses the ima_appraise= command line parameter.
> > >
> > > So let's refactor this code a little bit, by using a core_param()
> > > callback to capture the command line argument, and deferring any
> > > reasoning based on its contents to the IMA init routine.
> > >
> > > Cc: Chester Lin <clin@suse.com>
> > > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > > Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > > Cc: James Morris <jmorris@namei.org>
> > > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > > Link: https://lore.kernel.org/linux-arm-kernel/20200904072905.25332-2-clin@suse.com/
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > > v2: rebase onto series 'integrity: improve user feedback for invalid bootparams'
> >
> > Thanks, Ard.  Based on my initial, limited testing on Power, it looks
> > good, but I'm hesistant to include it in the integrity 5.10 pull
> > request without it having been in linux-next and some additional
> > testing.  It's now queued in the next-integrity-testing branch awaiting
> > some tags.
> >

Tested-by: Chester Lin <clin@suse.com>

I have tested this patch on x86 VM.

* System configuration:
  - Platform: QEMU/KVM
  - Firmware: EDK2/OVMF + secure boot enabled.
  - OS: SLE15-SP2 + SUSE's kernel-vanilla (=linux v5.9) + the follow commits
    from linux-next and upstream:
    * [PATCH v2] ima: defer arch_ima_get_secureboot() call to IMA init time
      https://www.spinics.net/lists/linux-efi/msg20645.html
    * e4d7e2df3a09 "ima: limit secure boot feedback scope for appraise"
    * 7fe2bb7e7e5c "integrity: invalid kernel parameters feedback"
    * 4afb28ab03d5 "ima: add check for enforced appraise option"

* Logs with UEFI secure boot enabled:

  [    0.000000] Linux version 5.9.0-858-g865c50e1d279-1.g8764d18-vanilla (geeko@b
  uildhost) (gcc (SUSE Linux) 10.2.1 20200825 [revision c0746a1beb1ba073c7981eb09f
  55b3d993b32e5c], GNU ld (GNU Binutils; openSUSE Tumbleweed) 2.34.0.20200325-1) #
  1 SMP Wed Oct 14 04:00:11 UTC 2020 (8764d18)
  [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.9.0-858-g865c50e1d279-1.
  g8764d18-vanilla root=UUID=5304c03e-4d8a-4d67-873a-32a32e57cdeb console=ttyS0,11
  5200 resume=/dev/disk/by-path/pci-0000:04:00.0-part4 mitigations=auto ignore_log
  level crashkernel=192M,high crashkernel=72M,low ima_appraise=off
  [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point regi
  sters'
  [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
  [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
  ....
  ....
  [    1.720309] ima: Secure boot enabled: ignoring ima_appraise=off option
  [    1.720314] ima: No TPM chip found, activating TPM-bypass!
  [    1.722129] ima: Allocated hash algorithm: sha256
  ....

> 
> Thanks. No rush as far as I am concerned, although I suppose Chester
> may want to rebase his arm64 IMA enablement series on this.

Yes, I've finished coding but still verifying it. As you have suggested,
My v2 patch will separate the get_sb_mode() from arch/x86 so that other
architectures can reuse it.

Thanks,
Chester

> 
> Suggestion: can we take the get_sb_mode() code from ima_arch.c in
> arch/x86, and generalize it for all EFI architectures? That way, we
> can enable 32-bit ARM and RISC-V seamlessly once someone gets around
> to enabling IMA on those platforms. In fact, get_sb_mode() itself
> should probably be factored out into a generic helper for use outside
> of IMA as well (Xen/x86 has code that does roughly the same already)
> 

