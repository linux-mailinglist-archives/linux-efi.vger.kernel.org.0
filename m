Return-Path: <linux-efi+bounces-2308-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9B89E6F8E
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 14:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34421883E6E
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7516207DF3;
	Fri,  6 Dec 2024 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="MSj7guEp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xDNgtnHy"
X-Original-To: linux-efi@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94A22066DE;
	Fri,  6 Dec 2024 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493144; cv=none; b=kb6VoE3kG/l1xrjhHQtLqz3djb+/svPwYng5Y2OJ4GzYMul0oFBNsv4Jyftq+lymRmMZXbaAygMkkzH43alovKusm/Jdt18WpuRsr3hKbGJjvyja5YJ3NU1lj272Q0OE4ARnI0udsAadi/m48JTkaaAuPEh3CATOnFyaQPWZF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493144; c=relaxed/simple;
	bh=Qg6Ce5uSEcP+55XWYkwP9vkeQ++48Pfctd6qXinl3Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlmuNeRnFgnW5J1zg2XC3ao5yvtDYNznys+fiJ2wPRjdPDLXeGMvPYRpIvHXdUMz71qZWGRlZWQPIigUWD/JgvMp67SBeahMpfMF4f3y/FC/NIRZoCJeDAl0HC6yBDdcNe60/+8ONja747ZJSWVdJA1yJKfpVPd6Stks6tIh1lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=MSj7guEp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xDNgtnHy; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 158141D40557;
	Fri,  6 Dec 2024 08:52:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 06 Dec 2024 08:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1733493138; x=
	1733500338; bh=F/P5NvV/oPgyLOVDdO9jbE313zKQetWBog6B0EvuLEA=; b=M
	Sj7guEpfYyfJVeSxZkmsMh0zyS2W2XOGFWxV1S085lP0oWUiSQf+HQv4B/im8Smb
	A/50JTK4DLLh18J9Sjqs2aNhk6S2yarJ+EHcouloSh/oqCB7hArt2q3ZuIFbkj/I
	fFgU9Qg9R5ZGGvT47CzpDp1KUbo7nK9HO2ae1NPXsXP/wl5BchFWD0yg/JCYjsr9
	fXIJRALKFsKvFqe71MneVTz8jaGQLkP6wUACGnoi/5zIDs6FZV9i4SCRlzylZIdL
	JEk2HHQSDWp63JDjM2qb1hil4JrLTf5nQRDL1cyESz6dFceNZAlsmT22L0W8F1gH
	86D9/srMF3PNNTLIIkUqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733493138; x=1733500338; bh=F/P5NvV/oPgyLOVDdO9jbE313zKQetWBog6
	B0EvuLEA=; b=xDNgtnHy1tK7puhnLX5+esK/IgziPC4HzD0yPzyaPgVs8BauerX
	5Gh9QHIIwI9c+CUD9aR7FksVyc+wiv9c8kDcmUBxhh3LvOEfxlVik7VuxrqmuwTf
	XafAHjl0THPYXeq+RMCHSq+xyRbTf81BcpKLtm5vGNbxwyK3XhqSKKD0/eNEBIEs
	ifGsiqyf80HwoUEiHyMx99sbVBdhIbumQXWTwZBPE4uZQkwcPkqT1sz1khwQ5fKP
	5LvTH20FG+Z0W6OgHmIRX0xxkcJ4AsJgifC3XCJZIrNaVdO1xmRRG8EZSEdZAiGB
	55jZB+7jQTMglESe+lwBG7aRRXR4qQbb60A==
X-ME-Sender: <xms:kgFTZ9eRxZgsQ_HyW0NQeyBhAa8qrP-js82jZsEnrc73rIKbqI5cQg>
    <xme:kgFTZ7NeULk2V4bgBoKUbD2I9wnDfcKDJoG1qVHeHqzZoP8DCptzP2hkGxpDbhB_u
    HTxZFgGNz0vK71z6CA>
X-ME-Received: <xmr:kgFTZ2h8sZq6o250A96V6I672leVJ0PaesW6z8yf8EHC8ehGiJXlNNIQaY-eGODpBFung7qO_vhuMVEX_XB2I8ZKk7sWPvGZxo8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhteetgfekvdeiueff
    veevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgt
    tghhihdrjhhppdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepiihijhhunhgphhhusehitghlohhuugdrtghomhdprhgtphhtthhopehgrhgv
    ghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehukhhlvg
    hinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrmhgvshdrsghothhtohhm
    lhgvhieshhgrnhhsvghnphgrrhhtnhgvrhhshhhiphdrtghomhdprhgtphhtthhopehthh
    homhgrshesthdqkegthhdruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhvughimhhmsehlihhsthhsrd
    hlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqshhouhhnugesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsphgrrhgtlhhinhhugiesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kgFTZ2_UGngVtygK4_p0LKXvJr2g0v9oePYeEVcrzT0gkzTro-YK0g>
    <xmx:kgFTZ5vx35KJMQHqHYcHa0QjhtFrNmuU_ZD5-UGD0krqFfoJC4mPyQ>
    <xmx:kgFTZ1G9NWKiaU4m6BL1Na5OaZRNRdHCaRGEc0E-ttIN_XuEHc32wg>
    <xmx:kgFTZwPzQVAELvWI33zBnvWj1s6ncPtql6n1UYpP22HdnXi_-3k-FA>
    <xmx:kgFTZ4-yVlVkD3Q8ajGh0oXdOkDvMdTtHW1-CAta77ld53oKIK-nLbK0>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:52:12 -0500 (EST)
Date: Fri, 6 Dec 2024 22:52:09 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-sound@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-block@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, arm-scmi@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-gpio@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v3 04/11] driver core: Constify API device_find_child()
 then adapt for various usages
Message-ID: <20241206135209.GA133715@workstation.local>
Mail-Followup-To: Zijun Hu <zijun_hu@icloud.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-sound@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-block@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, arm-scmi@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-gpio@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com>
 <20241205-const_dfc_done-v3-4-1611f1486b5a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-const_dfc_done-v3-4-1611f1486b5a@quicinc.com>

Hi,

On Thu, Dec 05, 2024 at 08:10:13AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Constify the following API:
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> To :
> struct device *device_find_child(struct device *dev, const void *data,
>                                  device_match_t match);
> typedef int (*device_match_t)(struct device *dev, const void *data);
> with the following reasons:
> 
> - Protect caller's match data @*data which is for comparison and lookup
>   and the API does not actually need to modify @*data.
> 
> - Make the API's parameters (@match)() and @data have the same type as
>   all of other device finding APIs (bus|class|driver)_find_device().
> 
> - All kinds of existing device match functions can be directly taken
>   as the API's argument, they were exported by driver core.
> 
> Constify the API and adapt for various existing usages by simply making
> various match functions take 'const void *' as type of match data @data.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  arch/sparc/kernel/vio.c                |  6 +++---
>  drivers/base/core.c                    |  6 +++---
>  drivers/block/sunvdc.c                 |  6 +++---
>  drivers/bus/fsl-mc/dprc-driver.c       |  4 ++--
>  drivers/cxl/core/pci.c                 |  4 ++--
>  drivers/cxl/core/pmem.c                |  2 +-
>  drivers/cxl/core/region.c              | 21 ++++++++++++---------
>  drivers/firewire/core-device.c         |  4 ++--
>  drivers/firmware/arm_scmi/bus.c        |  4 ++--
>  drivers/firmware/efi/dev-path-parser.c |  4 ++--
>  drivers/gpio/gpio-sim.c                |  2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c |  2 +-
>  drivers/hwmon/hwmon.c                  |  2 +-
>  drivers/media/pci/mgb4/mgb4_core.c     |  4 ++--
>  drivers/nvdimm/bus.c                   |  2 +-
>  drivers/pwm/core.c                     |  2 +-
>  drivers/rpmsg/rpmsg_core.c             |  4 ++--
>  drivers/scsi/qla4xxx/ql4_os.c          |  3 ++-
>  drivers/scsi/scsi_transport_iscsi.c    | 10 +++++-----
>  drivers/slimbus/core.c                 |  8 ++++----
>  drivers/thunderbolt/retimer.c          |  2 +-
>  drivers/thunderbolt/xdomain.c          |  2 +-
>  drivers/tty/serial/serial_core.c       |  4 ++--
>  drivers/usb/typec/class.c              |  8 ++++----
>  include/linux/device.h                 |  4 ++--
>  include/scsi/scsi_transport_iscsi.h    |  4 ++--
>  net/dsa/dsa.c                          |  2 +-
>  tools/testing/cxl/test/cxl.c           |  2 +-
>  28 files changed, 66 insertions(+), 62 deletions(-)

For the changes in FireWire subsystem:

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thanks

Takashi Sakamoto

