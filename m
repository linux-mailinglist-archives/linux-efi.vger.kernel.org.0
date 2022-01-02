Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4111C482AA2
	for <lists+linux-efi@lfdr.de>; Sun,  2 Jan 2022 10:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiABJNJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Jan 2022 04:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiABJNJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Jan 2022 04:13:09 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12060C061574
        for <linux-efi@vger.kernel.org>; Sun,  2 Jan 2022 01:13:09 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j18so64186293wrd.2
        for <linux-efi@vger.kernel.org>; Sun, 02 Jan 2022 01:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=g8Z10qgIS0EarfPNyU/0T6kl3UEk/EndXdl7judHSI4=;
        b=cT9F3DzmUcRxWxFD4sSOd/3kM/FzYaq9R5aPZVHTSj0y6vgeZIiCU9KIorpANInfrs
         /z2xJJAQutlnqyPOy2TJvNK5aClq/0APzp7zw/5TqWx/A3R3D61xAMaHnIrFgCWXg9du
         I6RNyc6Utwp2jPFgQFJgN6xeDEHrPz402z94aw3+VTdzbqD30qCR1bs/hCll4lZwX5rB
         6meIirmAS+UgMeg7CTswrAMMov5ldjkvXr9oIAutytPxMVHJHOkb9rktaX+xB6OHJ+U/
         2MdmT3Zofa6fCkgHiVSZqIC1TjD8Opo3EZtB34OOXplfj5uySdQTb3hxV06k9zn3KiRV
         Xmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=g8Z10qgIS0EarfPNyU/0T6kl3UEk/EndXdl7judHSI4=;
        b=QrsVN1fwQNl6yY9TclvzYC+KP36MtAGAG4TbdNOszb5BsZZCWn80htAW0hBM6wIqkT
         FhC7cT+MBuolF/i2foAD4xzmaw4+4UZ86oe09Vp72k0OxRe4Sa8uEYCeHjuiAqUWkLTO
         PkzIQCgGIwXHgObIma2w8CEU7RX16+uADX00QcPfJb2vS8HkkPmOvkaKvgXkJQoTd5d1
         TsJnijQS1g0skRu9EuW+iLO0rARIi+R6VeX+eYHY35q8dbO2SLMyLcnevzSl2jjUMy6p
         JeZZQphCm63QAF/3CSYwW2bP4fJ+dN98DwoLezF5FFZGRILqsjOC5vo+cpVJ7YAVfqwi
         lYZA==
X-Gm-Message-State: AOAM530+mdnW5YeB0+pCPq3mKLR6pQLdswC0SpMY2EljGAy9UnYaHWiT
        /QnE59Kxm+EIR9PpziWjPo0=
X-Google-Smtp-Source: ABdhPJygb0M2aRqlRBt5evpiJ17xDyaWIEMwr8hZh9dH3mSKNuVcFnFhKy5g4mX6ZTKC+9mYdkZWzw==
X-Received: by 2002:a05:6000:184f:: with SMTP id c15mr35761467wri.632.1641114786832;
        Sun, 02 Jan 2022 01:13:06 -0800 (PST)
Received: from [192.168.9.102] ([197.211.59.105])
        by smtp.gmail.com with ESMTPSA id r11sm35983605wrz.78.2022.01.02.01.13.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 02 Jan 2022 01:13:06 -0800 (PST)
Message-ID: <61d16ca2.1c69fb81.5a583.7a9c@mx.google.com>
From:   Margaret Leung KO May-yeee <hafsatharunamuazu4424@gmail.com>
X-Google-Original-From: Margaret Leung KO May-yeee
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Gesch=C3=A4ftsvorschlag?=
To:     Recipients <Margaret@vger.kernel.org>
Date:   Sun, 02 Jan 2022 10:12:58 +0100
Reply-To: la67737777@gmail.com
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Am Mrs. Margaret Leung I have a business proposal for you reach at: la67737=
777@gmail.com

Margaret Leung
Managing Director of Chong Hing Bank
