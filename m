Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9236254A53
	for <lists+linux-efi@lfdr.de>; Thu, 27 Aug 2020 18:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgH0QPH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Aug 2020 12:15:07 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:49403 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbgH0QPB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Aug 2020 12:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1598544898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kwXRAFPcKE5bsBPfUSrIfN7z/A+5a3sdVt5OCi5/LUA=;
        b=K0wOBPE6w5YRviXQOU8nv3ELke+A40HfjLSQssGvOYrZayVY3EunvhSGIS29PexzDKiI+X
        aED8A9KWUs1BwGmRbRZ38oyV8rmViHFSFObJdu77CDJrFiGKKvxbiJsCmnrBaFpW8cUR2S
        eUVsge2ezaai2s9AQtZKfNfGY0mY96E=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-14-LXwzhDAvOGi4PN0VEuMbBQ-2; Thu, 27 Aug 2020 18:14:57 +0200
X-MC-Unique: LXwzhDAvOGi4PN0VEuMbBQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAIXFoflaxzsfmJ1y6WshCw/NGV95rdTu35TbGK97FXZj6WccF1DTxKR7ZLPskwhmQwTd3kD2H6C2eD/ptfEEtmGQ8upigC0ph6sCcjancjAi+arjIUW+1CAOA4isibK/WiYX+ougjczyG1sRYdDLobFKPosBquconHqZ1JADapYy8bxxkvUWXJoXXWAlNoHPvNiCrOAFiLjHWibBooJ/ryZiWS30QVks6HVL9FqYa1YiEeaYrcUjWk1XMPa3i2Y9WXit7rLacWoKOZ7UsSO8VpZpwwpbrmSZmgYmTy5FcTYX0FfkYhUoE+qz3HHOQQgU6zFbNkQcHoJ/zxXg2xbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwXRAFPcKE5bsBPfUSrIfN7z/A+5a3sdVt5OCi5/LUA=;
 b=JN3SLZKxE2ZEs5VF+P3Civ1bUQUMni54moqZDl9vFP1MXHTmzdk5PtDZKmWz5yDdTvrbOXxRrVfL2YbveDnJWSl2Jvl+43z54MiNGx7cFcnu5uRHSqiKKY9GIZXaj5zUY+iTsilnsHF9Sq2suHPJOHcS8E+DWETSuybCyInGRgbT+xU+mUXU6xJZAkQdaLYgKi1ukU0U+qni9l4PP23oE1gN1gY4gHJ097/Ea2xjX+maoDzZYuxDwD/KAFcrERGxKCTymNj2fk/znIaZEmPhSAVAs6d6Hcyns2IGoxn04c8pv2BqIw3gaf+D0dcEpAjEvnkijJZile/kJpCDIberWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12)
 by VI1PR04MB4574.eurprd04.prod.outlook.com (2603:10a6:803:6f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 27 Aug
 2020 16:14:54 +0000
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::c8e6:73d6:6e2e:9adf]) by VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::c8e6:73d6:6e2e:9adf%5]) with mapi id 15.20.3326.021; Thu, 27 Aug 2020
 16:14:54 +0000
Date:   Fri, 28 Aug 2020 00:14:41 +0800
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
Message-ID: <20200827161441.GH7501@linux-l9pv.suse>
References: <20200826004607.7483-1-jlee@suse.com>
 <CAMj1kXHAmUVPs=P5ptb3J95+4epP5fQXkBZ_+vLP8xfxri8VBw@mail.gmail.com>
 <20200826155633.GC7501@linux-l9pv.suse>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826155633.GC7501@linux-l9pv.suse>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HK2P15301CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::31) To VI1PR04MB7102.eurprd04.prod.outlook.com
 (2603:10a6:800:124::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-l9pv.suse (124.11.22.254) by HK2P15301CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4 via Frontend Transport; Thu, 27 Aug 2020 16:14:51 +0000
X-Originating-IP: [124.11.22.254]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e262664-d86a-4b0f-c2e9-08d84aa45573
X-MS-TrafficTypeDiagnostic: VI1PR04MB4574:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB45747D3B144F24AD4E589D13A3550@VI1PR04MB4574.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0bsbjChze4ZKXfvY8rY9nDeyPXJUVzgt19fz9j2Q9fMLAlPTJUH/enKWZ/cBpGGxvHxu+f6Abv3IZHHanWojJupqU1pYWgZEamRGSxcvK6NS3fMhTkAxBaOmg5qNA8MBr0iyNZj4fAH06uNr76hMOzfPGWTBuiGali4uv1Fp8x02vfKDt4LHLVgy3RujuDfDvEFuaMJdtN9nOJhLWs/ABKoVEriwWzndl3vA5pQPypwefmFTKUYm0peLN2X9grXMKLSavtZ2ZRyobmSs8Rw2m7nkUzjP2HDiDPuiLWBB+dokCJ6FH5TnynTutRT3Qdn9Q38LvawR2SUsGeAQ7xMm+YBzwN4hYseZsY5JZyN4E+8fVOA0hNA5EuysdkmkJ8V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7102.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(39860400002)(376002)(2906002)(55016002)(8886007)(86362001)(6506007)(53546011)(52116002)(7696005)(4326008)(9686003)(33656002)(5660300002)(16526019)(83380400001)(186003)(36756003)(6666004)(8676002)(1076003)(6916009)(478600001)(26005)(956004)(66946007)(66556008)(8936002)(316002)(54906003)(66476007)(43062003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1Pgu0Ss/DLi1W1okNnNPd9rzuHgoWRirqK4Wtr+gctBDHWh84tV2q0miQkHz9hHAxMexGK3I4zsTQscrlNmAY7IUsp4VMnkLOnlup+v0l3hgTskggQZc4Y2Tzlz4FLYqzt5ic6oNeVlc11EByfP9NtKhe9TYijodUfxRM1m+kLS/7czGXSxJIBhxYNrK/8DJK34s4uY3k+F4T0d8F13ISnbi150pFGOAa+2NNuL53PjLLuIMNPNkq3QpNkKbpn2TmxLE63wc6TddyYHAm9axU53sKPs1FQn9zVd1FJrXpMAs0azUhBGRRjo4XMHdQuRaEpfYI4N+f3ZcULxdWHxPxGo3w6snJ27eelDjVX/ZaqzLGMoDaxWRrnf7MXOCYz1HcGjIE143WrOh7BQuQFxWFkEGtro/6Fc2zLBdhpuBYNAZYI8iuK2xMk4emus+TJ9171IKLYJbTzuoUY3psy/o31c3SR+0YQ6P1uVhvSVDYFj6ZUffthohsz2FYqfWwPUbnsNOX+u16M4UuM6VuQNsFy7vlJl7XMYZvC5c1aEpai0M0bCgsIgAnpVjYWrX4Rrv2XfuN8WUd0eTUg/uMfTOcazZlLAYTdwIn/e797NLJ/XLz/L0jenQXF2Gm52Ol7Fcunr04j4gvR916d7cvTW7cg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e262664-d86a-4b0f-c2e9-08d84aa45573
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7102.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 16:14:54.2931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNKCL3H5weRck9Ik+YgKEb8GtxWDP776OkqaUsTVT1Qa76VGEAVRO6QEfLvjFZGu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4574
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 26, 2020 at 11:56:33PM +0800, Joey Lee wrote:
> Hi Ard,
> 
> On Wed, Aug 26, 2020 at 02:08:18PM +0200, Ard Biesheuvel wrote:
> > On Wed, 26 Aug 2020 at 02:46, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > >
> > > This patch creates efivars mount point when active efivars abstraction
> > > be set. It is useful for userland to determine the availability of efivars
> > > filesystem.
> > >
> > > Cc: Matthias Brugger <mbrugger@suse.com>
> > > Cc: Fabian Vogt <fvogt@suse.com>
> > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > 
> > Apologies for not bringing this up before: while the patch seems fine,
> > I wonder if we really need this if the purpose is to decide whether
> > efivars is available or not. We already have the 'efivars' platform
> > device for this, and so userland can simply check for the existence of
> > 
> > /sys/devices/platform/efivars.0
> > 
> > and so we don't need to make any changes for this.
> > 
> 
> The platform device only be registered on generic EFI runtime services
> platform. If the efivars abstraction is google gsmi, then userland can
> not use efivars.0 to detectmine the availability of efivars filesystem.
> 
> If we only consider generic EFI platform, then efivars.0 is good enough.
> But if the gsmi implementation joins this game, then my patch should not
> blocks the creation of efivars mount point because gsmi_kobj is not
> initialized yet.
> 
> Maybe the creation of efivars mount point can be moved to
> efivars_register(), after the kobject be set. Then gsmi can also create
> mount point. How do you think?
> 

Here is the patch for my concept. I simply tested on qemu-OVMF and
qemu-uboot.

From 7c81d3f058a177bb17c4589fe1863b79940f94c3 Mon Sep 17 00:00:00 2001
From: "Lee, Chun-Yi" <jlee@suse.com>
Date: Fri, 28 Aug 2020 00:05:22 +0800
Subject: [PATCH] efi/efivars: Create efivars mount point in the registration
 of efivars abstraction

This patch moved the logic of creating efivars mount point to the registration
of efivars abstraction. It is useful for userland to determine the availability
of efivars filesystem by checking the existence of mount point.

Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
---
 drivers/firmware/efi/efi.c  |  7 -------
 drivers/firmware/efi/vars.c | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 3aa07c3b5136..23c11a2a3f4d 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -405,13 +405,6 @@ static int __init efisubsys_init(void)
 	if (error)
 		goto err_remove_group;
 
-	/* and the standard mountpoint for efivarfs */
-	error = sysfs_create_mount_point(efi_kobj, "efivars");
-	if (error) {
-		pr_err("efivars: Subsystem registration failed.\n");
-		goto err_remove_group;
-	}
-
 	if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
 		efi_debugfs_init();
 
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 973eef234b36..6fa7f288d635 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -1179,6 +1179,8 @@ int efivars_register(struct efivars *efivars,
 		     const struct efivar_operations *ops,
 		     struct kobject *kobject)
 {
+	int error;
+
 	if (down_interruptible(&efivars_lock))
 		return -EINTR;
 
@@ -1191,6 +1193,19 @@ int efivars_register(struct efivars *efivars,
 
 	up(&efivars_lock);
 
+	/* and the standard mountpoint for efivarfs */
+	if (efi_kobj) {
+		error = sysfs_create_mount_point(efi_kobj, "efivars");
+		if (error) {
+			if (down_interruptible(&efivars_lock))
+				return -EINTR;
+			__efivars = NULL;
+			up(&efivars_lock);
+			pr_err("efivars: Subsystem registration failed.\n");
+			return error;
+		}
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(efivars_register);
@@ -1222,6 +1237,8 @@ int efivars_unregister(struct efivars *efivars)
 
 	pr_info("Unregistered efivars operations\n");
 	__efivars = NULL;
+	if (efi_kobj)
+		sysfs_remove_mount_point(efi_kobj, "efivars");
 
 	rv = 0;
 out:
-- 
2.16.4

Thanks a lot!
Joey Lee

> On the other hand, the efisubsys_init() does not unregister efivars.0
> platform device in err_unregister block. It causes that efivars and
> efi-pstore be loaded when no generic_ops.
> 
> Let me know if I miss understood any thing, please.
> 
> 
> > 
> > 
> > > ---
> > >
> > > v2:
> > > Using efivars_kobject() helper instead of checking GetVariable or
> > > GetNextVariable EFI runtime services. Because the efivarfs code could be
> > > instantiated using a different efivars abstraction.
> > >
> > >  drivers/firmware/efi/efi.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > index 3aa07c3b5136..db483fc68501 100644
> > > --- a/drivers/firmware/efi/efi.c
> > > +++ b/drivers/firmware/efi/efi.c
> > > @@ -405,11 +405,13 @@ static int __init efisubsys_init(void)
> > >         if (error)
> > >                 goto err_remove_group;
> > >
> > > -       /* and the standard mountpoint for efivarfs */
> > > -       error = sysfs_create_mount_point(efi_kobj, "efivars");
> > > -       if (error) {
> > > -               pr_err("efivars: Subsystem registration failed.\n");
> > > -               goto err_remove_group;
> > > +       if (efivars_kobject()) {
> > > +               /* and the standard mountpoint for efivarfs */
> > > +               error = sysfs_create_mount_point(efi_kobj, "efivars");
> > > +               if (error) {
> > > +                       pr_err("efivars: Subsystem registration failed.\n");
> > > +                       goto err_remove_group;
> > > +               }
> > >         }
> > >
> > >         if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
> > > --
> > > 2.16.4
> > >

