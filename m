Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB1753694F
	for <lists+linux-efi@lfdr.de>; Sat, 28 May 2022 02:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355217AbiE1AL7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 May 2022 20:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355212AbiE1AL6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 May 2022 20:11:58 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469EE118019
        for <linux-efi@vger.kernel.org>; Fri, 27 May 2022 17:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1653696713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/eVQJAWvjJOG1Vu5tfXl2kxZZU3hrOV16Q0Z8xKacw=;
        b=fvCYFVkp3voyWpD5AqfLjBepPs+uren6MIdXFmzOY9DABo3SKoD9GWOAYZQLteuCBg11ew
        Pp1vLwSlptSYVZMY0AyNPHdRUD9GDpWli8+HZTg2xk1+RKmTD5uLDg/bSxv3969CGYjABZ
        4zTMFWGUL1dYFMxfdL6DJG4M1qFO51Q=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2058.outbound.protection.outlook.com [104.47.9.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-7V6hikuXNP28Ln7XDSdCzA-1; Sat, 28 May 2022 02:11:51 +0200
X-MC-Unique: 7V6hikuXNP28Ln7XDSdCzA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj6S6VBURoHtIOGJ/N8Rx9hxZHhFzq3hWMAvWGWtu8shyikefcP3dax+0+1yEjX9cgTzQlPxeXxlJkPSlU8RQk7B2mkn8KTY9Iq8Lx5fiWofJjqrMpVmhaKZ+eUas56pMWexyqG4EtGBOsvGMo+8X1+VlMO6JvAzz165zfazfZJF/HncbtVDPfkNRcu/I8Fm17x1uaN57frtlUiSmZjo1myVbj8bMW0IAbsWNqRdKv9ev09ySqxv2e9EdDHWZtSqfV565TnaH+NVK55BNa87uBTIt4S9wq1GfJIwLsuJA7N2Qg+UjW8/LYXIU6V+Vqw2NG6m4YOJx8DCObjK/d+h+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/eVQJAWvjJOG1Vu5tfXl2kxZZU3hrOV16Q0Z8xKacw=;
 b=B2U9NQ/96pci6Z8WJa46mPaVPOBxHLdANNIj6+nPqHLoDyfpeK5qYZ+Oa1Zwl1zqpxQB+p6bBP3xqk7I6c/KeABJgoRRS24sX7VOF3DI1W2MhtUVA9w0DpQUEo4XtcMZmgIssZoQ36hv7DBw35thmaS5FG1ewv0nKOsHE73qts6Vez8k+0p0MX+dhVcbCYp8OSgJOQ/CZq7axTgy9enSux8O+tOvcNBaWywO29CGKMCGB8OtweHViqGC1a51tbEwr4D/ncCZEqenPqGGxzgItq5Iu9QsjSiva/vHLD0vHC/Pg0YJ6ES5nssJXmuxM0PaMDkMfqbK6FvSDC2v0ITa4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13)
 by DU0PR04MB9370.eurprd04.prod.outlook.com (2603:10a6:10:359::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Sat, 28 May
 2022 00:11:49 +0000
Received: from VI1PR04MB7165.eurprd04.prod.outlook.com
 ([fe80::9c84:55dd:207e:4ef9]) by VI1PR04MB7165.eurprd04.prod.outlook.com
 ([fe80::9c84:55dd:207e:4ef9%9]) with mapi id 15.20.5293.015; Sat, 28 May 2022
 00:11:48 +0000
Date:   Sat, 28 May 2022 08:11:37 +0800
From:   joeyli <jlee@suse.com>
To:     linux-security-module@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jforbes@redhat.com, Matthew Garrett <mjg59@google.com>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH 18/30] acpi: Disable APEI error injection if the kernel
 is locked down
Message-ID: <20220528001137.GL4162@linux-l9pv.suse>
References: <151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
 <151024877315.28329.472560163492858160.stgit@warthog.procyon.org.uk>
 <20191107082131.GI12016@linux-l9pv.suse>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107082131.GI12016@linux-l9pv.suse>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: HK2PR04CA0066.apcprd04.prod.outlook.com
 (2603:1096:202:14::34) To VI1PR04MB7165.eurprd04.prod.outlook.com
 (2603:10a6:800:125::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d55556ad-dbb7-4f35-e692-08da403ea7ff
X-MS-TrafficTypeDiagnostic: DU0PR04MB9370:EE_
X-Microsoft-Antispam-PRVS: <DU0PR04MB9370F993816BD284B18790DDA3DB9@DU0PR04MB9370.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2IiYcrsjE74WjPPryfoJaV0yNJxNGgy00Yz++3vMowwF6U1KgyVdP7UI+mK2Fd8DI11DGwmPFE4cBZ9JmQ8zT7cSNPk+TVOCnk4Cmqi+GVq91rCtG+HmyrnZoYMBDT0Mf8fRPwj9omX0+cvOmdppTr1xcpkGEB7IEIYYk/zsvZVmBIYrU6y9fudNd77jWZntwdEKv1BqYEPASu/fU3Cyj5aHAx8BqFB73NbWkquiqfuU8Cb+qU9GZGPjmaXtIgj1wxYv6DqY5h+IUKPb0swctET5KFVIxHQx+XhQEZVDerIdWPqQpdmIHUszMymhOmyze9tV47hbP1i3Q0OcluETTKvy0Z5dXslHg02McNCFfMhuC40L8Np3LXY4sOZtwkYaOe1t8puH5QAuRPbKmUJtk0en21+ePHPylABQC2XPA22eYhLjmZpyNXnr1jSb79FDuBfbn7zj+h54CfFKBtSYUiorW/m86GRvANEicYoFl6kDfkzkxqBPMHedoT68hfsxDZuMB9nRkp2XDGwszhSHmmJXGji6GCz/nhUR3FXAy5IyObnkaVISwUe+GCJqLW1IdNyrxzBg9IzD+00ZzyDLVsPxk0VF6u2R39JvkLKG9vIfgtBJaZ8+1Csm1SvEMQ6rEDKJWtE4/tVaBi/1afA867cpQv7/k8kvLRY3kos8Jg2IvKpwBlzXjZ0FZlOp1wAy/7TPiv2kKCpH4Exo+WISMx0OAgIEBXEkZ9yZSIjtrfNIPAtk7vke8Yo3ZqOlSZ3ewE7t/3CcyOHrZgHIPkc5bg/DHl/5Gpouze9xCFL5ezOK3D9c9qN8yUZelIsqktn3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7165.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66556008)(86362001)(66946007)(66476007)(6512007)(316002)(9686003)(26005)(6666004)(6506007)(38100700002)(54906003)(6916009)(508600001)(6486002)(966005)(2906002)(1076003)(83380400001)(33656002)(36756003)(186003)(8936002)(5660300002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IAewyTT1FAW1yovN2ZWFnSb5cMFE93lxiuKKsMdcgb4D9HmWMc1QavylqIQ7?=
 =?us-ascii?Q?w3HlYjMwoiu/Uo92sBbWL/aK3HX9JID3oyliGNk5ZcQ0F9QPBS0VuqIN4NlU?=
 =?us-ascii?Q?hPBmJqlrbf5ZITyIxXXo+WjjDVaUedXz5l0JETVsmErNmS5Y7ccF0HNTqLZq?=
 =?us-ascii?Q?lNZerY24toxwocyUFh7gVZOy/lq/rmkHtAdH3mc478u4U8BGb8p+2UQbwIgi?=
 =?us-ascii?Q?xaKg4k7wVSHTby0xz4NFxG230aTo0aulViV3pexHxWWv5DL9j67VzmmVR+/U?=
 =?us-ascii?Q?aMwagtXD4SnLQx7W6i9asG9YqFbDB3ooa/4tJOCtNtNk3VUhaGndamMr4XX1?=
 =?us-ascii?Q?XafV0eDzjEI6phZfAW3e9hG4hAE6Vo/L+U+4ZYgisbhh90rUeevexzNA1uKN?=
 =?us-ascii?Q?SmpjCwTTl9FUKonYPfjIffO/v28vWFhSGl/k03DGGMMie7Nm+Pme1XXSHWWe?=
 =?us-ascii?Q?nRyDWfH2bzgQHD2LO8uiHA9y4GZTDK+PypFmbDkSjmjAhwQ8eZppcN8JoIpT?=
 =?us-ascii?Q?wTnq3llz3ucgR549H0uaqciZK95s+d+RPOSPpLSi5yeJRieCAC/3Md38iRQw?=
 =?us-ascii?Q?8+5C+dA7H1Y7wH9ZB46vClnzSyMvbfT0Q4W6ShLUCc8eliVhYO4xcbAmuUMD?=
 =?us-ascii?Q?14VWQW529oMkiSL0V/0TsIznWZTqT7rjWX79+p6Yvt9RDwqc1oSYEcyhtDyi?=
 =?us-ascii?Q?mWAiC/3RIRDVnoELgh/11tXiK2KSHrQZUNJrAXPvyie9HQ0H48abZ16A/3TX?=
 =?us-ascii?Q?aLudFyoFiYZf6TM0QnjSjWvI/cqR3OyL5a0pgDy59N8t6gt3P/2LLUXrFcAa?=
 =?us-ascii?Q?rwKmwyDYPa2R9VIaaZ7+z9Nhu4qAOzkIYZNNhe+6vePXS6e3L2RbrFI7SC8S?=
 =?us-ascii?Q?TvI3jlnagm2ws0LcpYNebuODMkrsXldJwM5qBrNPghr56VF3oAMNDpVVAylZ?=
 =?us-ascii?Q?LPmcLTlZUaIVs+EkAEmK/ysh7GMG1mTeBrhSaYn2nyor/opZdTT0N09DxK9Q?=
 =?us-ascii?Q?1jg5Oj5fC6W4+eW1882OenzXkADQorZHhAqbYRApQsiUSrfjdrgEbtgoBF6s?=
 =?us-ascii?Q?9BOqDLI4YQ+9TEjPQ9Ber4HfYo2Le2h+XFTW/AgC+TkdW3AlNY3JUTYKiFZd?=
 =?us-ascii?Q?57CLOhx+CxmhDI4FmtyNrn2QYRMahCLqfdgVMPY4FpMF7wHJQZQxgU/kfFri?=
 =?us-ascii?Q?h/mQMgucY2Xy8GvcPDJFzwhuOJdknswYdXnfi/kcvxcjICKTrstLYNojSoZw?=
 =?us-ascii?Q?SBBud4IvJmMAwhSlokRFyxeqiAjOeEMoFT1v6eid9mHo/mfoUG5MRylsblZH?=
 =?us-ascii?Q?WsozasO9LYwewyN3KVJb6wM4da6shb25XLn6mcvg3kW3J1+HVhkLMl/82zSJ?=
 =?us-ascii?Q?UQ1zgAD/NAijk9rBRcHTH+9m+9MD4FUzUIE7Ac+/mBnqrzqhq9TL/GkMJx7s?=
 =?us-ascii?Q?9zAN7+qhZf8e7NNwVrhJGMDNzY5AwSZ7enSl3gFZnrxCVjgFBFNNejuapQNp?=
 =?us-ascii?Q?pClKhcq48z0mTS+vLslQSZj3/o8SZsU1pcCNgfx3S3ksvJL9c5uWAJWDlpS8?=
 =?us-ascii?Q?fInOcDjkkdqguCKS0S2ojOAlEJbLIii+EEBrEvEauaaDDF2iYIQpH2iCon5G?=
 =?us-ascii?Q?2F8xaCxH8IMcgt39HiBBuwxh6gjMWIIRvrL+BcUxX8VhA8HVXuxbzx0WqUvf?=
 =?us-ascii?Q?nx0oTXweI6kqlIIDpDhvczHiGsYaJQoQNP/2AdmavvCPV8dn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55556ad-dbb7-4f35-e692-08da403ea7ff
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7165.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2022 00:11:48.0186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jv+ph+oGGx4MNS7xHRWnf/cwlCe2avfYJVgdV/VdLaYTvGE7nYYXNj26wuh4UWpb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9370
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi all,

On Thu, Nov 07, 2019 at 04:21:31PM +0800, joeyli wrote:
> Hi experts,
> 
> On Thu, Nov 09, 2017 at 05:32:53PM +0000, David Howells wrote:
> > From: Linn Crosetto <linn@hpe.com>
> > 
> > ACPI provides an error injection mechanism, EINJ, for debugging and testing
> > the ACPI Platform Error Interface (APEI) and other RAS features.  If
> > supported by the firmware, ACPI specification 5.0 and later provide for a
> > way to specify a physical memory address to which to inject the error.
> > 
> > Injecting errors through EINJ can produce errors which to the platform are
> > indistinguishable from real hardware errors.  This can have undesirable
> > side-effects, such as causing the platform to mark hardware as needing
> > replacement.
> > 
> > While it does not provide a method to load unauthenticated privileged code,
> > the effect of these errors may persist across reboots and affect trust in
> > the underlying hardware, so disable error injection through EINJ if
> > the kernel is locked down.
> > 
> > Signed-off-by: Linn Crosetto <linn@hpe.com>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
> > cc: linux-acpi@vger.kernel.org
> 
> I was looking at the lockdown pathes in v5.4-rc kernel and found that the
> "acpi: Disable APEI error injection if the kernel is locked down" did not
> merged with lockdown patch set. This patch be sent with Matthew's pull
> request lockdown patches for 5.2:
>     http://kernsec.org/pipermail/linux-security-module-archive/2019-March/012033.html
> 
> But it didn't show in Morris's git:
>     https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git/log/?h=next-lockdown
> 
> Maybe I missed some detail of this patch. Could anyone point out the
> concern of this patch please?
>

After a couple of years, we still didn't have this patch in mainline. 
Does that mean the "APEI error injection" doesn't need to be locked down?

Actually this patch is against a CVE-2016-3695:
https://nvd.nist.gov/vuln/detail/CVE-2016-3695

It's before lockdown patchset be merged to kernel mainline. So this CVE
happened in downstream destro. Just search CVE-2016-3695 then we can see
many distros has this.

If mainline kernel doesn't have this patch, then I believe that the
CVE-2016-3695 is also in current mainline kernel.

Then why this patch not be acceptted?

Thanks!
Joey Lee
 
> > ---
> > 
> >  drivers/acpi/apei/einj.c |    3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> > index b38737c83a24..6d71e1e97b20 100644
> > --- a/drivers/acpi/apei/einj.c
> > +++ b/drivers/acpi/apei/einj.c
> > @@ -518,6 +518,9 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> >  	int rc;
> >  	u64 base_addr, size;
> >  
> > +	if (kernel_is_locked_down("ACPI error injection"))
> > +		return -EPERM;
> > +
> >  	/* If user manually set "flags", make sure it is legal */
> >  	if (flags && (flags &
> >  		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-efi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Thanks
> Joey Lee

