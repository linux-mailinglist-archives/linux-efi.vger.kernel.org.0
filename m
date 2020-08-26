Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D81825341F
	for <lists+linux-efi@lfdr.de>; Wed, 26 Aug 2020 17:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgHZP5F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Aug 2020 11:57:05 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:40302 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728069AbgHZP5B (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Aug 2020 11:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1598457418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uKCSDTLvCh2BA1pp9NpWLCwOb2ee6k8Fan77uTOeP18=;
        b=OCf/kq7UffCjaDA9T4vDXw4BKor6sFIEwHe9GNHKF+GTmqRf1owuD1spkFYmrkc0iv0AsA
        Ax8bXwxkPHPvEmuZjzgnK+nyJkj/BGLyWO9csVKiVGEsuJts+B8b2/C4DP0lZlDInLlS/Z
        ZyGcZCC3G2zrw/3xyPk3rysFCdB9U3E=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-17-YwMZTblxOceyZjIr0Mf_mA-2; Wed, 26 Aug 2020 17:56:57 +0200
X-MC-Unique: YwMZTblxOceyZjIr0Mf_mA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWPJIPMU/dlytYlJ4/mEo6Kx7BPmUk3GGRM7kunkUBI4CIIeLdlhb5IUJYRQ3lHOI0LyqfjR3y9NZxhqEc7P2evBjjgwZfaSVPjsM0Wg3r5i9sjGMnX+XJmFrSpm0yWnWzjaOtochc3v2KFmdarOqPCZ7q9elexcikhnqbwagitQRFVXD7Ri+6l7Xs0pJwkO4JsPN3IjRI0x4iolIlO7eNB1MWrPh5ssvVrSKF42s+16SXSFHsr+MGFHlAQDbcr7ysHZHbiCEQ3dI5+7NpYcxOXpHYBDl9/RMqnmEJ1UP1NuD2Sfo1ZUzUT01p2/bJTJUo+oCv/vrG1vDdBJFZg7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKCSDTLvCh2BA1pp9NpWLCwOb2ee6k8Fan77uTOeP18=;
 b=TLybDcHvwFiTltmNUqO1OmatvxwZOz08nzZ5YklCtcNuV0k1CEvcExEUZLCnJbelhGEFY8jrUCTZwKZNotRNx3FkLzhg0iVU5itHRzdz1MEAlIk+Eh8kdyH5eWvd7GXoGJxusutIN2CPn4QztHB6juAhKCJPtilGDxQMCgnjIDX2rAj14mqu35Z5GHDO6RkLojHvFZ3TacI3At/o0SzHApfDsfmV2BWONvCpjLY4PdZYL/2ssnG/3fuij+LJNgmFihNQSiK/tTjLof+VCSZaNgXEZ2wi2ssPNhfo8Apv8ft3QLI32We7hYAVFddChe+v9n6q35Z6GMFb86hVZgs1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12)
 by VI1PR0402MB3472.eurprd04.prod.outlook.com (2603:10a6:803:a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 15:56:53 +0000
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::c8e6:73d6:6e2e:9adf]) by VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::c8e6:73d6:6e2e:9adf%5]) with mapi id 15.20.3305.031; Wed, 26 Aug 2020
 15:56:53 +0000
Date:   Wed, 26 Aug 2020 23:56:33 +0800
From:   joeyli <jlee@suse.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Fabian Vogt <fvogt@suse.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2] efi/efivars: Create efivars mount point via efivars
 abstraction
Message-ID: <20200826155633.GC7501@linux-l9pv.suse>
References: <20200826004607.7483-1-jlee@suse.com>
 <CAMj1kXHAmUVPs=P5ptb3J95+4epP5fQXkBZ_+vLP8xfxri8VBw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHAmUVPs=P5ptb3J95+4epP5fQXkBZ_+vLP8xfxri8VBw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HK2PR02CA0158.apcprd02.prod.outlook.com
 (2603:1096:201:1f::18) To VI1PR04MB7102.eurprd04.prod.outlook.com
 (2603:10a6:800:124::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-l9pv.suse (124.11.22.254) by HK2PR02CA0158.apcprd02.prod.outlook.com (2603:1096:201:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 15:56:48 +0000
X-Originating-IP: [124.11.22.254]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3223345b-4fd2-41e6-16f8-08d849d8a6bf
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3472:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3472A04AC2AD9B98B6F7EA77A3540@VI1PR0402MB3472.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYwnLURyGHni+d+pH+ZR3n94IXtxrqV2p6klSQeq7SR2GEZeyhz+v33UIs+Y5rOVmyP6H7Ub5udIc0ieyhluMGqTkJg5nqoeHol5DMqVtrmfIl7VIi439wCZJYI+43nhaDcpfqXcr7y2t4h5rSiulbLgToThfBH599K3GA9SViyqGGYAUbSe+syAQFnnZQRpnqDl4xo66qWhEydUw9LXF5IiySk8Cl7DYf0VpsuAosWosHI5bteS2jnk1XnCFTqLhL/DL9cIy4nMv30N9CSXhqnRzXq7iI3ej6nJsTAt8U9hNr+w9Zn0OmQb/hXCGQnJMSLegATp5u+jjT7NTAAG4DnRFLafDKMrr28OAIPunC63qujHYmYwOdoeQKRpGDLp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7102.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39860400002)(366004)(396003)(5660300002)(6916009)(4326008)(8676002)(956004)(66556008)(8936002)(66476007)(66946007)(316002)(36756003)(9686003)(6666004)(55016002)(54906003)(33656002)(186003)(52116002)(26005)(1076003)(7696005)(86362001)(83380400001)(6506007)(16526019)(478600001)(8886007)(2906002)(43062003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: m2Z7sysdmd+QX7vwwAH6twZyOqlZEUQ6XvhFTTF3QjR0869Zlz54X39zC+RWAjZ6ZKlqQKTjr0r4RoRp3kqYPoFDxoRNJe6Cs1TsX/LLKNarJM1mHrPRktgfbSwAwQPAWBuAvz2ctffxYwyRfOn8XjfyiM1mbIrZuIBDSWm7HnnjI/CrBC922YTdGJyZfjLZsKgrcyNeA+5se/5BYDKuilbzuSFk1oSJE5dOqw34bzG/Qat46ljZytj/7IPlMvCu1pjinRx0avr6L80kcjqASsjZ5T+fwXFvJQlQ8hgJbOLapb7IcDQVipE5WtzvewcGCqw/08v6KrQbvBbkneNCQ8bgYvK0anwjuQchzRWjVT32PESoRKtAoQKHiRolgHyM45sPTAJ3csu/Zas9f/6NBSP6A0oxzGmnGCxLAr4pzOGkdi9gbCPoyb98DbeHKgwEHse/Susv/a6+RHf21mFfvMB9ql/+502kAuzpcIAEH8Yqnu0KbfofMtbNaT0oGHGCYdJDsVjKOoW1CeAnjZnRRArQ5myc03T2xY8GqFBULMprUHYvkutyH5M6LM8buiFmMNqweQcO969zkxbCt16gSHy+c+y7VolHQ7UbljGzBwF3bpvPcJNFYC56l3bK9+EetCgT3VMroesRzAui7LyGQA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3223345b-4fd2-41e6-16f8-08d849d8a6bf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7102.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 15:56:53.4997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1d68OhzYndgye/cnSUBg89f962VIWnrYhAh5ynv+xVSd3nH8+RmCBNds2RlzHLo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3472
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Wed, Aug 26, 2020 at 02:08:18PM +0200, Ard Biesheuvel wrote:
> On Wed, 26 Aug 2020 at 02:46, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> >
> > This patch creates efivars mount point when active efivars abstraction
> > be set. It is useful for userland to determine the availability of efivars
> > filesystem.
> >
> > Cc: Matthias Brugger <mbrugger@suse.com>
> > Cc: Fabian Vogt <fvogt@suse.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> 
> Apologies for not bringing this up before: while the patch seems fine,
> I wonder if we really need this if the purpose is to decide whether
> efivars is available or not. We already have the 'efivars' platform
> device for this, and so userland can simply check for the existence of
> 
> /sys/devices/platform/efivars.0
> 
> and so we don't need to make any changes for this.
> 

The platform device only be registered on generic EFI runtime services
platform. If the efivars abstraction is google gsmi, then userland can
not use efivars.0 to detectmine the availability of efivars filesystem.

If we only consider generic EFI platform, then efivars.0 is good enough.
But if the gsmi implementation joins this game, then my patch should not
blocks the creation of efivars mount point because gsmi_kobj is not
initialized yet.

Maybe the creation of efivars mount point can be moved to
efivars_register(), after the kobject be set. Then gsmi can also create
mount point. How do you think?

On the other hand, the efisubsys_init() does not unregister efivars.0
platform device in err_unregister block. It causes that efivars and
efi-pstore be loaded when no generic_ops.

Let me know if I miss understood any thing, please.

Thanks a lot!
Joey Lee

> 
> 
> > ---
> >
> > v2:
> > Using efivars_kobject() helper instead of checking GetVariable or
> > GetNextVariable EFI runtime services. Because the efivarfs code could be
> > instantiated using a different efivars abstraction.
> >
> >  drivers/firmware/efi/efi.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 3aa07c3b5136..db483fc68501 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -405,11 +405,13 @@ static int __init efisubsys_init(void)
> >         if (error)
> >                 goto err_remove_group;
> >
> > -       /* and the standard mountpoint for efivarfs */
> > -       error = sysfs_create_mount_point(efi_kobj, "efivars");
> > -       if (error) {
> > -               pr_err("efivars: Subsystem registration failed.\n");
> > -               goto err_remove_group;
> > +       if (efivars_kobject()) {
> > +               /* and the standard mountpoint for efivarfs */
> > +               error = sysfs_create_mount_point(efi_kobj, "efivars");
> > +               if (error) {
> > +                       pr_err("efivars: Subsystem registration failed.\n");
> > +                       goto err_remove_group;
> > +               }
> >         }
> >
> >         if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
> > --
> > 2.16.4
> >

