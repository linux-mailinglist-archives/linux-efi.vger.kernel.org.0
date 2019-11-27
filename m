Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F88D10A95E
	for <lists+linux-efi@lfdr.de>; Wed, 27 Nov 2019 05:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfK0EUO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Nov 2019 23:20:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbfK0EUO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 26 Nov 2019 23:20:14 -0500
Subject: Re: [GIT PULL] ACPI updates for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574828414;
        bh=7U5QvbOcu2GrhmPv65Z5K1XMND22gyJT+/bvOU+tXtM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JqILwvzR1BsJxoAyrFiYdqGkCOKo2kTaSk7aJj/tnQq/wh942VjyvBbocQsgTNXlu
         QK6fedUdzir4oTXS7t7Aj73kKtbJzAO6Pth+yfM0ND99yiDXVC+jo4QG45R4ZQMMpD
         3hJWrD8p3bYncFROQ73w3Ytg8Ryl1Rt3t/eT82Nw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g944ZbCaoCvGcT7EFJVKW5efSMgf9oi_d3iP_3+iwbNg@mail.gmail.com>
References: <CAJZ5v0g944ZbCaoCvGcT7EFJVKW5efSMgf9oi_d3iP_3+iwbNg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g944ZbCaoCvGcT7EFJVKW5efSMgf9oi_d3iP_3+iwbNg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.5-rc1
X-PR-Tracked-Commit-Id: 782b59711e1561ee0da06bc478ca5e8249aa8d09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e9f879684b46331f51d0c76ebee981c788417db
Message-Id: <157482841395.9403.2315371254751175937.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 04:20:13 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 13:59:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e9f879684b46331f51d0c76ebee981c788417db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
