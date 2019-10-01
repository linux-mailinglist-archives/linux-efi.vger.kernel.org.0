Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC8AC43E0
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2019 00:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbfJAWmD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Tue, 1 Oct 2019 18:42:03 -0400
Received: from www17.your-server.de ([213.133.104.17]:43456 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbfJAWmD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Oct 2019 18:42:03 -0400
X-Greylist: delayed 1787 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Oct 2019 18:42:02 EDT
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1iFQNR-0004im-Mv
        for linux-efi@vger.kernel.org; Wed, 02 Oct 2019 00:12:13 +0200
Received: from [2a02:908:4c22:ec00:94c:bc63:8eb6:4404]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1iFQNR-00028Y-85
        for linux-efi@vger.kernel.org; Wed, 02 Oct 2019 00:12:13 +0200
Date:   Wed, 02 Oct 2019 00:11:57 +0200
User-Agent: K-9 Mail for Android
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: 5.3.1: x86: efi stub seems to fail to load initrd file
To:     linux-efi@vger.kernel.org
From:   Thomas Meyer <thomas@m3y3r.de>
Message-ID: <D6FD0BFD-0934-4D9B-986C-89ED5CF13FE5@m3y3r.de>
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25589/Tue Oct  1 10:30:33 2019)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

I've got this old x86 MacBookPro1,1 and I wanted to switch to systemd-boot.

systemd-boot works fine but the Linux efistub somehow fails to load the initrd, sadly the monitor seems to be switched off/no backlight after systemd-boot menu selection and Linux kernel starting efifb.

Any ideas what could be the culprit?
I tried to boot with efi=nochunk but same result.

I tried to understand what systemd boot does for file loading and what libefistub does, it looks very similar.

So any ideas and hints are welcome what is maybe wrong in my setup.

When I embedded the initramfs in the kernel, boot of Linux and system works correctly.

Ps: all efi_printk seems to be lost in the kernel. Is there a way to transfer this into the kernel somehow?

With kind regards
Thomas
