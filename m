Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9FE2B4A86
	for <lists+linux-efi@lfdr.de>; Mon, 16 Nov 2020 17:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbgKPQQZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Nov 2020 11:16:25 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39065 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731584AbgKPQQY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Nov 2020 11:16:24 -0500
Received: by mail-oi1-f193.google.com with SMTP id f11so5657823oij.6;
        Mon, 16 Nov 2020 08:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RulTdcnrDdgWwh+nP28RdtMK+5PSTx7xbD183jhCfRg=;
        b=gsvre2nrqUc2qHrHJ7e+IBWvTGItUadsk0q0QUSnd1wXx5U3IJfIMIYRVxrSJYVuiO
         kzIA1pPaqoGxfvVvr+IMSpXFrv5NDw+BXKM+RpjesjANrZczMS1L51laOFYgc3eq68Pr
         zB11YaAMuFSfMCSRYMyufkUgTp9uXKB2Q6VeFXLEYWQQGBcPzax3eTY3yUSdBdFuhQMw
         8ywZNqBCyzOZgFeygRKCv1EjphnoTnKaHAh+h5/Sbb0deIuA2uwsCjKGrDXeYFiMPOtd
         FOjbGTSMNuJFgEBjW5wPomk6qc2IgSK3N6VmGxvD2ndgpLNsGOuR6QxzcUqunNGqOlTp
         O89w==
X-Gm-Message-State: AOAM531EiHlTqbVyEpMSDDqSxifbX9m86ZVqTq8r5pX4h57B0RKos7Cu
        r3+TVgL0fZX+/l/e0mzjw+VOUMzOBcGueKVafJ6oYv73
X-Google-Smtp-Source: ABdhPJxsHoEXWLRAORs5wepqnqHAJYHejMJqY+2GjEKGW2k5uWBE2yOHAhuQvULJijVttPy9eq/yXXN3AAcA8pzR3b8=
X-Received: by 2002:aca:c4c9:: with SMTP id u192mr142060oif.69.1605543381818;
 Mon, 16 Nov 2020 08:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com> <20201104232356.4038506-12-saravanak@google.com>
In-Reply-To: <20201104232356.4038506-12-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Nov 2020 17:16:10 +0100
Message-ID: <CAJZ5v0hxdq2prUUkoPwpW5+crAD096eYQAQ7PZ2oaFKT7_gcHA@mail.gmail.com>
Subject: Re: [PATCH v1 11/18] driver core: Redefine the meaning of fwnode_operations.add_links()
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 5, 2020 at 12:24 AM Saravana Kannan <saravanak@google.com> wrote:
>
> Change the meaning of fwnode_operations.add_links() to just create
> fwnode links by parsing the properties of a given fwnode.
>
> This patch doesn't actually make any code changes. To keeps things more
> digestable, the actual functional changes come in later patches in this
> series.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  include/linux/fwnode.h | 42 +++---------------------------------------
>  1 file changed, 3 insertions(+), 39 deletions(-)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index afde643f37a2..ec02e1e939cc 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -78,44 +78,8 @@ struct fwnode_reference_args {
>   *                            endpoint node.
>   * @graph_get_port_parent: Return the parent node of a port node.
>   * @graph_parse_endpoint: Parse endpoint for port and endpoint id.
> - * @add_links: Called after the device corresponding to the fwnode is added
> - *             using device_add(). The function is expected to create device
> - *             links to all the suppliers of the device that are available at
> - *             the time this function is called.  The function must NOT stop
> - *             at the first failed device link if other unlinked supplier
> - *             devices are present in the system.  This is necessary for the
> - *             driver/bus sync_state() callbacks to work correctly.
> - *
> - *             For example, say Device-C depends on suppliers Device-S1 and
> - *             Device-S2 and the dependency is listed in that order in the
> - *             firmware.  Say, S1 gets populated from the firmware after
> - *             late_initcall_sync().  Say S2 is populated and probed way
> - *             before that in device_initcall(). When C is populated, if this
> - *             add_links() function doesn't continue past a "failed linking to
> - *             S1" and continue linking C to S2, then S2 will get a
> - *             sync_state() callback before C is probed. This is because from
> - *             the perspective of S2, C was never a consumer when its
> - *             sync_state() evaluation is done. To avoid this, the add_links()
> - *             function has to go through all available suppliers of the
> - *             device (that corresponds to this fwnode) and link to them
> - *             before returning.
> - *
> - *             If some suppliers are not yet available (indicated by an error
> - *             return value), this function will be called again when other
> - *             devices are added to allow creating device links to any newly
> - *             available suppliers.
> - *
> - *             Return 0 if device links have been successfully created to all
> - *             the known suppliers of this device or if the supplier
> - *             information is not known.
> - *
> - *             Return -ENODEV if the suppliers needed for probing this device
> - *             have not been registered yet (because device links can only be
> - *             created to devices registered with the driver core).
> - *
> - *             Return -EAGAIN if some of the suppliers of this device have not
> - *             been registered yet, but none of those suppliers are necessary
> - *             for probing the device.
> + * @add_links: Create fwnode links to all the suppliers of the fwnode. Return
> + *             zero on success, a negative error code otherwise.

I'd say something like "Create fwnode links to all nodes that
represent devices supplying resources to the device represented by the
current fwnode.  Return ..., or a negative ... on failure."

>   */
>  struct fwnode_operations {
>         struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
> @@ -155,7 +119,7 @@ struct fwnode_operations {
>         (*graph_get_port_parent)(struct fwnode_handle *fwnode);
>         int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
>                                     struct fwnode_endpoint *endpoint);
> -       int (*add_links)(const struct fwnode_handle *fwnode,
> +       int (*add_links)(struct fwnode_handle *fwnode,
>                          struct device *dev);
>  };
>
> --
> 2.29.1.341.ge80a0c044ae-goog
>
