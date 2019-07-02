Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1212D5CFC7
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jul 2019 14:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfGBMuz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Jul 2019 08:50:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42666 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBMuz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Jul 2019 08:50:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id z25so27154945edq.9;
        Tue, 02 Jul 2019 05:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulgxsWYV0nRrSUUXQ81nMXkgbPlxNsLtNUXfKf0CzW0=;
        b=PGU4kucx1w6t8Ox8ljAkdvrxOgUTPzE/S0MVdvgINUOYMysVco2JNbgT5tERMLSo2g
         OgPPtEAqHYzRuTuPBcC/k/TLysjg8dY5B62NOZ9xct4buKZ5vhlwfDSypMuQA1GTu5Eo
         kqLMe+vENyooNGCRqiy57KK66QMzCRce3dlLulnTVZwDbk015cp7KMcsUi6pSR9vFWqX
         OsqhtKgcU8eAkeeyvIQwLRzAGd9Omwgv6yMZmlq3nZANX54VJKju91mECkopi1oxjH76
         zDyOLpsq9pp/PQib0G5hDvMvcPYZucwHCaOAGDYNeVdAGZkrHAnzZQmD0L1DUc/YiVT9
         +TyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulgxsWYV0nRrSUUXQ81nMXkgbPlxNsLtNUXfKf0CzW0=;
        b=fGPImvYbiat6g0+iVVSFF9K8LpI8+xjUXG5WIfDBeFZIfQEbYc1FSVWniyt32l+Hek
         Z3T5zbJRvDJabJMIVRdJsmFRovZuwGJ85nYcz84Ir3YncJic0qc6/88KZQWpIcLOv6IS
         NJGOIV3DxVL/SCQ4r20oiScVReTvSSqkKGSshnvW4/S/RoxibQPWcxPd3mE/cmSK5ydq
         w8BfflCMP9FkN2+LeWFgrzlqtuJ1qk4bNPWLUk7wa73ksEjHV2940JWslAV8gS4MFAG9
         ApYttNSd7ssfSTnMmZlSbzMEuPK3TkK0/5K6piEPh2XLo3/hxPO1I/7HMklvH/DvtsRf
         ovjA==
X-Gm-Message-State: APjAAAVNBLtw58jR3ErlLgFrVFF+Er+7mCzzGwMWLF02W1sX/G+ZwUNJ
        Jw6tojBYj8LmIG28Ph6+Q9TFCfOezaoMKEsMIVw=
X-Google-Smtp-Source: APXvYqzkF+v7ZHn3YweY8uh0aG6jvfG865tKiirrQBWYXNuB/WA54ejTgSuxnWSEab0XYlhvVgeDpY68t3sALVFaa/A=
X-Received: by 2002:a17:906:3612:: with SMTP id q18mr29032681ejb.278.1562071852310;
 Tue, 02 Jul 2019 05:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190630203614.5290-1-robdclark@gmail.com>
In-Reply-To: <20190630203614.5290-1-robdclark@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 2 Jul 2019 05:50:36 -0700
Message-ID: <CAF6AEGv8EJPmje_8bpK8LmLdLFkOSQVJOg_CTS7C_HwVB6i9eQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm+dt+efi: support devices with multiple possible panels
To:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        aarch64-laptops@lists.linaro.org,
        Rob Clark <robdclark@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" 
        <linux-efi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Steve Capper <steve.capper@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jun 30, 2019 at 1:36 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Now that we can deal gracefully with bootloader (firmware) initialized
> display on aarch64 laptops[1], the next step is to deal with the fact
> that the same model of laptop can have one of multiple different panels.
> (For the yoga c630 that I have, I know of at least two possible panels,
> there might be a third.)
>
> This is actually a scenario that comes up frequently in phones and
> tablets as well, so it is useful to have an upstream solution for this.
>
> The basic idea is to add a 'panel-id' property in dt chosen node, and
> use that to pick the endpoint we look at when loading the panel driver,
> e.g.
>
> / {
>         chosen {
>                 panel-id = <0xc4>;
>         };
>
>         ivo_panel {
>                 compatible = "ivo,m133nwf4-r0";
>                 power-supply = <&vlcm_3v3>;
>                 no-hpd;
>
>                 ports {
>                         port {
>                                 ivo_panel_in_edp: endpoint {
>                                         remote-endpoint = <&sn65dsi86_out_ivo>;
>                                 };
>                         };
>                 };
>         };
>
>         boe_panel {
>                 compatible = "boe,nv133fhm-n61";
>                 power-supply = <&vlcm_3v3>;
>                 no-hpd;
>
>                 ports {
>                         port {
>                                 boe_panel_in_edp: endpoint {
>                                         remote-endpoint = <&sn65dsi86_out_boe>;
>                                 };
>                         };
>                 };
>         };
>
>         sn65dsi86: bridge@2c {
>                 compatible = "ti,sn65dsi86";
>
>                 ...
>
>                 ports {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>
>                         ...
>
>                         port@1 {
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
>                                 reg = <1>;
>
>                                 endpoint@c4 {
>                                         reg = <0xc4>;
>                                         remote-endpoint = <&boe_panel_in_edp>;
>                                 };
>
>                                 endpoint@c5 {
>                                         reg = <0xc5>;
>                                         remote-endpoint = <&ivo_panel_in_edp>;
>                                 };
>                         };
>                 };
>         }
> };
>

Just to put out an alternative idea for how to handle this in DT
(since Laurent seemed unhappy with the idea of using endpoints to
describe multiple connections between ports that *might* exist.

This approach would require of_drm_find_panel() to check the
device_node to see if it is a special "panel-select" thing.  (I think
we could use device_node::data to recover the actual selected panel.)

On the plus side, it would work for cases that aren't using of_graph
to connect display/bridge to panel, so it would be pretty much
transparent to drivers and bridges.

And I guess it could be extended to cases where gpio's are used to
detect which panel is attached..  not sure how far down that road I
want to go, as jhugo mentioned elsewhere on this patchset, in some
cases dsi is used to select (which could be problematic to do from
kernel if display is already active in video mode scanout), or efuses
which aren't accessible from kernel.


    chosen {
        panel-id = <0xc4>;
    };

    panel_select {
        compatible = "linux,panel-select";
        #address-cells = <1>;
        #size-cells = <0>;

        boe_panel {
            compatible = "boe,nv133fhm-n61";
            reg = <0xc4>;
            power-supply = <&vlcm_3v3>;
            no-hpd;
        };

        ivo_panel {
            compatible = "ivo,m133nwf4-r0";
            reg = <0xc5>;
            power-supply = <&vlcm_3v3>;
            no-hpd;
        };

        ports {
            port {
                panel_in_edp: endpoint {
                    remote-endpoint = <&sn65dsi86_out>;
                };
            };
        };
    };

    dsi_controller_or_bridge {
        ...
        ports {
            ...
            port@1 {
                reg = <1>;
                sn65dsi86_out: endpoint {
                    remote-endpoint = <&panel_in_edp>;
                };
            };
        };
    };

Personally I find my original proposal more natural (which is why I
went with it, this second idea is more similar to what I initially had
in mind before looking at of_graph).  And it seems to be a bit weird
to have a panel_select thing which isn't really hardware.

BR,
-R
