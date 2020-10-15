Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6405228F1E6
	for <lists+linux-efi@lfdr.de>; Thu, 15 Oct 2020 14:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgJOMRD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Oct 2020 08:17:03 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:35765 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbgJOMRD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Oct 2020 08:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1602764219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V32FRI8vjGEyULrlSVnHeFvjBrj2PFylPSC1V3EZx18=;
        b=WO9auTZAp2fIQNNzUe7OLENCfXo9pERBuZvLF+5lvYT4cLQqr8auo0IPTtYN8GJtMXd3Om
        4Tks9dZc9HjcCOX/ZM8fbps7WZ07YrxUx2qtFBOSCVmFWif/PVJfT4j5/gH6s3a5M9hIY+
        0kZsty+1U0SNrmNF3LvQu7MW+DLleLE=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2054.outbound.protection.outlook.com [104.47.2.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-kNa5JcGHMFWy-ICGj6D_3g-1; Thu, 15 Oct 2020 14:16:57 +0200
X-MC-Unique: kNa5JcGHMFWy-ICGj6D_3g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXbhemr1Z2hHwIFbHP8VLt7yajqvfnKIAQw5/JblaRqwbIBL1aE6MhWIGEkCwhcaQST1dxQ243qMrf8Y12GjHkueo5ZMz6JFnDI7wAI7xqXVxy1gET1yB3nsKtnXiLJ1MzK39/LXkXynWK7eX/2wcvkXvZeV3PDv7hkAJTPZpafSU1SZCaC1RpXZdljHN/INRD8iwFklNZzp6GlcaWcnKl0bSOTI8bkaCQGRyLLlQdtaSB+WxRUq+TyNqdysX6LiHResAAwqV5OX1PZiLEutvrQWoO2cCfw05FNZ5ePFBxxotkOpuLZ4dTYV1UJmwIBbRTXYhgZDy+6sHz23rRAVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V32FRI8vjGEyULrlSVnHeFvjBrj2PFylPSC1V3EZx18=;
 b=ENFlXjHx6nE2zzI5oW5EhuQ69P0P3jth+GPIub/Nis/aEhOJgUTN0Dc1EP3RCPBLHAuiCtl2ezIlf58aKmJo4h09QJgmrpuDcARxU+RfxZaPz6ZmyDlb3E3C0fOu6XrvPaVvDhq+ZEBvb6Gg3PAPFbyHu5sRzrA3PGTc39/A3H6QYbYEDFtXzLcdsHR18Jlbm741Na6+eIAHZ3/IeTloW9sr95GVWsWDU/yEukUzbhlBwdwtTT+RZ3dHHCDykqP2SYs2Y4GXJGLGToEm3z+yvmGvxPZts9eXcDzEmFQS+zwW+Dz6oG5ee4mnCTl+FUdDGp6aSbpCU0UDWFDy4g+pqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR0401MB2479.eurprd04.prod.outlook.com (2603:10a6:800:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 15 Oct
 2020 12:16:54 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::e922:583c:a9bf:66e0]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::e922:583c:a9bf:66e0%6]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 12:16:54 +0000
Date:   Thu, 15 Oct 2020 20:16:38 +0800
From:   Chester Lin <clin@suse.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>, jlee@suse.com, clin@suse.com
Subject: Re: [PATCH v2] ima: defer arch_ima_get_secureboot() call to IMA init
 time
Message-ID: <20201015121638.GA18969@linux-8mug>
References: <20201013081804.17332-1-ardb@kernel.org>
 <ae9ab2560f6d7b114726efb1ec26f0a36f695335.camel@linux.ibm.com>
 <CAMj1kXFZVR46_oeYTxJ59q-7u+zFCFtOQuSQoiEzKLhXzpydow@mail.gmail.com>
 <20201014093531.GA9408@linux-8mug>
 <98b04c130708893ebefdf81e127a66356b4a6129.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98b04c130708893ebefdf81e127a66356b4a6129.camel@linux.ibm.com>
X-Originating-IP: [220.141.82.61]
X-ClientProxiedBy: AM4PR0302CA0002.eurprd03.prod.outlook.com
 (2603:10a6:205:2::15) To VI1PR04MB4928.eurprd04.prod.outlook.com
 (2603:10a6:803:57::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (220.141.82.61) by AM4PR0302CA0002.eurprd03.prod.outlook.com (2603:10a6:205:2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Thu, 15 Oct 2020 12:16:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e060a3c-10c6-42df-be25-08d8710433dc
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2479173B86C6EDDA35283C96AD020@VI1PR0401MB2479.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VKV25l7QRIE8RErTjOabO/4S9b/iJsjNr8iU8t6/rbOl5xbwOE7gtr8zLFcMSNRCOiUjUmY1MQyVNQTX0QOCRKiSWgQLbTKtMCb5XF4hanDvrUfiBSvyhGSJ+9tXBql8K5bDVB6pMOFXO7RAP/ZYLkuuiQA1yaTJPIWmJcfWJjje9pudSr0gW79AcWXgGHWaeuko2uf9WDh50L29Y+rj+HD1YShJ7fPCLkoATNiCj+I784Ls2H45ZV8QSkAzFIohiFoJtLLU0dp9m4DknqBP3rqLx8aaV0qpdSnRTqBTlRLcq6eBtCDFEzHhGPOHHxL2maUMSYrhXhd0jMVuEAclOA+8GgHMg4UL9XbG0BMC0jVBHRekjx3mOHEN4CJHIT4XSQRLWe5DkODTDdm7In/9sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(366004)(396003)(376002)(346002)(8676002)(26005)(16526019)(186003)(6666004)(1076003)(4326008)(33656002)(2906002)(86362001)(956004)(4001150100001)(6916009)(52116002)(8936002)(5660300002)(107886003)(6496006)(66476007)(33716001)(478600001)(83080400001)(66946007)(966005)(54906003)(55016002)(9686003)(83380400001)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: i8f+Wo71UyZ4/2QqNqOZ968FZ8gXn0kHNApvSjsJdk2ym0RUgJLkg15ZAHSRK7QcISSUzkvEVZBCJZIKpH1AIam0TR2o3qSLXccImdDB+VjSOgmj5gFYw19nBM8+UYASfBZM0/lZKMia8GlsBoU8izeZzc2e01pEgaqp2EEnI7B7ktpb1qp/l38qDMrvXcnOIsk9U8yz9befrnRi0jH7wayMCQr7U5juESitgMmiHoYncAk2kjZ8qVlKHOocyb3YTzXENXgtlNC9Nc7s8cno/tPclEZWo4bjaSAanq58CLPLpbEkUKr7bxUsG+naec16eCHcpw3INvMiaQcFowPtwx7pYdxAKwUOApkeswzpodSBeMsW3e4JHzPJw3jM9ac5PA4fahuCfKsB8iwLG5Vl3DPCVX58RJbK7lOheSTXimdJmxq7MbSOdhCu8dRTn93wQzvE803m9LkYgUdg69UljvtlO9426W8h4evw0w0lG1vciG2bCCqH+JJ+q/SVntErEHvK/vVYPmK542L75LL+gPKFIqnWbN9XR4SK7FjX4jE7ksH8OpRF2lJrSToZeRtAWBNQyWmzAT+DWKwr1MtQyBSEoenw5NJilhNrul8oMSUtq3Yg2K154CnkWmO/FvYL4IOWJhvp/7GZIP+Q0aNJlQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e060a3c-10c6-42df-be25-08d8710433dc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 12:16:54.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgjrhnZH+uKNqqpKMPqJmkkzDfCYZV2lLZfcmgG5ki2kuHy7ECyZnRyOpqma8FNm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2479
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 14, 2020 at 07:38:50AM -0400, Mimi Zohar wrote:
> On Wed, 2020-10-14 at 17:35 +0800, Chester Lin wrote:
> > Hi Ard & Mimi,
> > 
> > On Tue, Oct 13, 2020 at 06:59:21PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 13 Oct 2020 at 18:46, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > >
> > > > [Cc'ing linuxppc-dev@lists.ozlabs.org]
> > > >
> > > > On Tue, 2020-10-13 at 10:18 +0200, Ard Biesheuvel wrote:
> > > > > Chester reports that it is necessary to introduce a new way to pass
> > > > > the EFI secure boot status between the EFI stub and the core kernel
> > > > > on ARM systems. The usual way of obtaining this information is by
> > > > > checking the SecureBoot and SetupMode EFI variables, but this can
> > > > > only be done after the EFI variable workqueue is created, which
> > > > > occurs in a subsys_initcall(), whereas arch_ima_get_secureboot()
> > > > > is called much earlier by the IMA framework.
> > > > >
> > > > > However, the IMA framework itself is started as a late_initcall,
> > > > > and the only reason the call to arch_ima_get_secureboot() occurs
> > > > > so early is because it happens in the context of a __setup()
> > > > > callback that parses the ima_appraise= command line parameter.
> > > > >
> > > > > So let's refactor this code a little bit, by using a core_param()
> > > > > callback to capture the command line argument, and deferring any
> > > > > reasoning based on its contents to the IMA init routine.
> > > > >
> > > > > Cc: Chester Lin <clin@suse.com>
> > > > > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > > > > Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > > > > Cc: James Morris <jmorris@namei.org>
> > > > > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > > > > Link: https://lore.kernel.org/linux-arm-kernel/20200904072905.25332-2-clin@suse.com/
> > > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > ---
> > > > > v2: rebase onto series 'integrity: improve user feedback for invalid bootparams'
> > > >
> > > > Thanks, Ard.  Based on my initial, limited testing on Power, it looks
> > > > good, but I'm hesistant to include it in the integrity 5.10 pull
> > > > request without it having been in linux-next and some additional
> > > > testing.  It's now queued in the next-integrity-testing branch awaiting
> > > > some tags.
> > > >
> > 
> > Tested-by: Chester Lin <clin@suse.com>
> > 
> > I have tested this patch on x86 VM.
> > 
> > * System configuration:
> >   - Platform: QEMU/KVM
> >   - Firmware: EDK2/OVMF + secure boot enabled.
> >   - OS: SLE15-SP2 + SUSE's kernel-vanilla (=linux v5.9) + the follow commits
> >     from linux-next and upstream:
> >     * [PATCH v2] ima: defer arch_ima_get_secureboot() call to IMA init time
> >       https://www.spinics.net/lists/linux-efi/msg20645.html
> >     * e4d7e2df3a09 "ima: limit secure boot feedback scope for appraise"
> >     * 7fe2bb7e7e5c "integrity: invalid kernel parameters feedback"
> >     * 4afb28ab03d5 "ima: add check for enforced appraise option"
> > 
> > * Logs with UEFI secure boot enabled:
> > 
> >   [    0.000000] Linux version 5.9.0-858-g865c50e1d279-1.g8764d18-vanilla (geeko@b
> >   uildhost) (gcc (SUSE Linux) 10.2.1 20200825 [revision c0746a1beb1ba073c7981eb09f
> >   55b3d993b32e5c], GNU ld (GNU Binutils; openSUSE Tumbleweed) 2.34.0.20200325-1) #
> >   1 SMP Wed Oct 14 04:00:11 UTC 2020 (8764d18)
> >   [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.9.0-858-g865c50e1d279-1.
> >   g8764d18-vanilla root=UUID=5304c03e-4d8a-4d67-873a-32a32e57cdeb console=ttyS0,11
> >   5200 resume=/dev/disk/by-path/pci-0000:04:00.0-part4 mitigations=auto ignore_log
> >   level crashkernel=192M,high crashkernel=72M,low ima_appraise=off
> >   [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point regi
> >   sters'
> >   [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> >   [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> >   ....
> >   ....
> >   [    1.720309] ima: Secure boot enabled: ignoring ima_appraise=off option
> >   [    1.720314] ima: No TPM chip found, activating TPM-bypass!
> >   [    1.722129] ima: Allocated hash algorithm: sha256
> 
> 
> Thank you for testing the options aren't being set in secure boot mode.
> My main concern, however, is that IMA doesn't go into TPM-bypass mode. 
> Does this system have a TPM?
> 
> Mimi
>

Last time I didn't emulate a TPM device in KVM so that's why the kernel couldn't
find a TPM chip. I have tested this patch again with a virtual TPM 1.2 by
running swtpm and here are some logs:

-----
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
.....
.....
[    0.000000] efi: EFI v2.60 by EDK II
[    0.000000] efi: SMBIOS=0x7fe82000 ACPI=0x7feb0000 ACPI 2.0=0x7feb0014 MEMATTT
R=0x7ef89698 RNG=0x7ea12e18
[    0.000000] efi: seeding entropy pool
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[    0.000000] Hypervisor detected: KVM
.....
.....
[    1.957625] Linux agpgart interface v0.103
[    1.961903] tpm_tis 00:04: 1.2 TPM (device-id 0x1, rev-id 1)
[    1.966306] tpm tpm0: starting up the TPM manually
[    1.981753] ahci 0000:00:1f.2: version 3.0
[    1.984503] PCI Interrupt Link [GSIA] enabled at IRQ 16
.....
.....
[    2.086645] ima: Secure boot enabled: ignoring ima_appraise=off option
[    2.086650] ima: Allocated hash algorithm: sha256
[    2.100662] evm: Initialising EVM extended attributes:
[    2.100689] audit: type=1807 audit(1602760724.564:2): action=measure func=KEX
EC_KERNEL_CHECK res=1
[    2.101849] evm: security.selinux
[    2.101849] evm: security.apparmor
[    2.101849] evm: security.ima
[    2.101850] evm: security.capability
[    2.101850] evm: HMAC attrs: 0x1
[    2.102083] PM:   Magic number: 8:588:327
[    2.106723] audit: type=1807 audit(1602760724.564:3): action=measure func=MODD
ULE_CHECK res=1
[    2.118761] RAS: Correctable Errors collector initialized.
.....
-----


In terms of TPM 2.0, swtpm seems to have issues while running the selftest so
I verified this patch on my laptop as well because it has a real TPM 2.0 chip:

-----
[    0.000000] microcode: microcode updated early to revision 0xd6, date = 2020-
04-27
[    0.000000] Linux version 5.9.0-858-g865c50e1d279-1.g8764d18-vanilla (geeko@b
uildhost) (gcc (SUSE Linux) 10.2.1 20200825 [revision c0746a1beb1ba073c7981eb09f
55b3d993b32e5c], GNU ld (GNU Binutils; openSUSE Tumbleweed) 2.34.0.20200325-1) #
1 SMP Wed Oct 1404:00:11 UTC 2020 (8764d18)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.9.0-858-g865c50e1d279-1.
g8764d18-vanilla root=UUID=2184bbb7-780e-48a2-98b8-3a8cd3366e5e splash=silent re
sume=/dev/disk/by-id/ata-INTEL_SSDSCKKF512G8_SATA_512GB_BTLA82850G3E512K-part3 i
gnore_loglevel crashkernel=222M,high crashkernel=72M,low ima_appraise=log
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point regi
sters'
.....
.....
[    0.000000] efi: EFI v2.60 by American Megatrends
[    0.000000] efi: ACPI=0x7a34e000 ACPI 2.0=0x7a34e000 SMBIOS=0xf0000 SMBIOS 3.
0=0xf0020 TPMFinalLog=0x7ac8b000 ESRT=0x7b0e0018 MEMATTR=0x7762d018 RNG=0x7b133f
18 TPMEventLog=0x6ab96018
[    0.000000] efi: seeding entropy pool
[    0.000000] random: fast init done
[    0.000000] SMBIOS 3.1.0 present.
[    0.000000] DMI: Dell Inc. Latitude 7490/0KP0FT, BIOS 1.14.0 01/22/2020
.....
.....
[    7.182711] Non-volatile memory driver v1.3
[    7.182748] Linux agpgart interface v0.103
[    7.210826] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFC, rev-id 1)
[    7.234324] ahci 0000:00:17.0: version 3.0
.....
.....
[    7.288573] integrity: Loading X.509 certificate: UEFI:MokListRT
[    7.289299] integrity: Loaded X.509 cert 'openSUSE Secure Boot CA: 6842600de22c4c477e95be23dfea9513e5971762'
[    7.289913] ima: Secure boot enabled: ignoring ima_appraise=log option
[    7.289921] ima: Allocated hash algorithm: sha256
[    7.314854] evm: Initialising EVM extended attributes:
[    7.314878] audit: type=1807 audit(1602778176.572:2): action=measure func=KEXEC_KERNEL_CHECK res=1
[    7.316656] evm: security.selinux
[    7.316659] evm: security.apparmor
[    7.318493] audit: type=1807 audit(1602778176.572:3): action=measure func=MODULE_CHECK res=1
[    7.320092] evm: security.ima
[    7.320093] evm: security.capability
[    7.322554] evm: HMAC attrs: 0x1

